From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should 'git config' support key with dot such as 'a.b'
Date: Mon, 17 Mar 2008 17:42:28 -0700
Message-ID: <7vhcf4ammj.fsf@gitster.siamese.dyndns.org>
References: <46dff0320803140124t1469defsf7002f720cf2002e@mail.gmail.com>
 <alpine.LSU.1.00.0803141138340.24600@racer.site>
 <46dff0320803171740of822d02medc5911e0d056eb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 01:43:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbPvC-0008Vq-Jr
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 01:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbYCRAmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 20:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYCRAmk
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 20:42:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbYCRAmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 20:42:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 566A62625;
	Mon, 17 Mar 2008 20:42:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 234A62624; Mon, 17 Mar 2008 20:42:31 -0400 (EDT)
In-Reply-To: <46dff0320803171740of822d02medc5911e0d056eb4@mail.gmail.com>
 (Ping Yin's message of "Tue, 18 Mar 2008 08:40:46 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77474>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Fri, Mar 14, 2008 at 6:39 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>>
>>
>>  On Fri, 14 Mar 2008, Ping Yin wrote:
>>
>>  > I find it is so annoying to write submodule definition as follows
>>  > (yeah, only url, without path)
>>  >
>>  > ------------------------------
>>  > [submodule 'crawler']
>>  >     url = url1
>>  > [submodule 'search']
>>  >     url = url2
>>  > ------------------------------
>>  >
>>  > I think the following form is more simple
>>  > ---------------------------------
>>  > [submodule]
>>  >      crawler.url = url1
>>  >      search.url = url2
>>  > ---------------------------------
>>  >
>>  > So, could we support such simpler form?
>>
>>  I don't like it at all.  Historically, we had much stricter rules on the
>>  variable names than the second part of the section names.
>>
>>  Also, your suggestion would make things even more confusing than beginners
>>  already complain Git is.

I am not interested in this at all.  I would usually say "it is not clear
what advantage this has", but in this case, I would rather say "it is
clear there is no advantage in this".
