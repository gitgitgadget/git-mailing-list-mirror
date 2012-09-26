From: Jens Bauer <jens-lists@gpio.dk>
Subject: Re: CRLF, LF ... CR ?
Date: Wed, 26 Sep 2012 12:12:39 +0200
Message-ID: <20120926121239151317.65a13153@gpio.dk>
References: <20120913170943725232.01d717ef@gpio.dk>
 <CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com>
 <7vtxv18ax2.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7Y5iXVxDHPJ+HQ86T43YBccnsEsebFje9pZzEBgh3=9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 12:12:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGobr-0004wJ-1W
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 12:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab2IZKMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 06:12:42 -0400
Received: from [92.246.25.51] ([92.246.25.51]:53766 "EHLO mail.multitrading.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752562Ab2IZKMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 06:12:41 -0400
Received: (qmail 16652 invoked from network); 26 Sep 2012 10:12:39 -0000
Received: from unknown (HELO ?10.0.2.26?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 26 Sep 2012 10:12:39 -0000
In-Reply-To: <CAJDDKr7Y5iXVxDHPJ+HQ86T43YBccnsEsebFje9pZzEBgh3=9A@mail.gmail.com>
X-Mailer: GyazMail version 1.5.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206403>

Hi David and Junio.

At first, I was planning to reply that I'd probably not be qualified for that.
But to tell the truth, I have been writing a lot of CR/LF/CRLF code throughout the years, so maybe I could do it.
Unfortunately, I have to go slow about programming, because I burned myself out a number of times, so programming "work" is not compatible with me; though programming "hobby" is.

The implementation would be dependent on on how git is currently handling lines.
Worst case is, if it's mixed CR, LF and CRLF, such as a text-file, that contains all 3 kinds of line endings (because 3 different people have been editing the file).


Love
Jens

On Wed, 26 Sep 2012 01:42:02 -0700, David Aguilar wrote:
> On Thu, Sep 13, 2012 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> David Aguilar <davvid@gmail.com> writes:
>> 
>>> git doesn't really even support LF.
>> 
>> At the storage level that is correct, but the above is a bit of
>> stretch.  It may not be "support", but git _does_ rely on LF when
>> running many text oriented operations (a rough rule of thumb is
>> "does 'a line' in a file matter to the operation?").  Think about
>> "git diff" and "git blame".
> 
> Thanks for the thorough explanation.  You're 100% correct, as always.
> 
> I'll be honest: I had a small bias when responding.
> I didn't want anyone to think a "autocr" feature would be useful,
> so I played the "git is really simple" angle hoping it would
> put a kabosh on the idea.  That was a little silly of me.
> 
> That said, perhaps the "autocrlf" code is simple enough that it
> could be easily tweaked to also handle this special case, but
> I am not familiar with the code enough to say.  My gut feeling
> was that it was too narrow a use case.  I guess if someone[*]
> wanted to whip up a patch then it would be a different story,
> but it doesn't seem to be the itch of anyone around here so far.
> 
> [*] Jens, that could be you ;-)
> 
> cheers,
> -- 
> David
