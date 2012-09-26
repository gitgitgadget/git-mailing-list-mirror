From: Jens Bauer <jens-lists@gpio.dk>
Subject: Re: CRLF, LF ... CR ?
Date: Wed, 26 Sep 2012 12:31:32 +0200
Message-ID: <20120926123132856121.5a7ecc44@gpio.dk>
References: <20120913170943725232.01d717ef@gpio.dk>
 <CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com>
 <7vtxv18ax2.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7Y5iXVxDHPJ+HQ86T43YBccnsEsebFje9pZzEBgh3=9A@mail.gmail.com>
 <20120926121239151317.65a13153@gpio.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Bauer <jens-lists@gpio.dk>
X-From: git-owner@vger.kernel.org Wed Sep 26 12:32:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGoup-0004Ts-FN
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 12:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab2IZKbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 06:31:35 -0400
Received: from [92.246.25.51] ([92.246.25.51]:53780 "EHLO mail.multitrading.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753477Ab2IZKbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 06:31:34 -0400
Received: (qmail 17005 invoked from network); 26 Sep 2012 10:31:33 -0000
Received: from unknown (HELO ?10.0.2.26?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 26 Sep 2012 10:31:33 -0000
In-Reply-To: <20120926121239151317.65a13153@gpio.dk>
X-Mailer: GyazMail version 1.5.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206404>

Hi David and Junio.

Woops, that's what happens when deleting a block of lines in a message...

The CR/LF/CRLF implementation depends a lot on if git is reading a stream or reading from memory.

I'd like to correct the last line to read...
Worst case is, if a file contains mixed CR, LF and CRLF, such as a text-file, that contains all 3 kinds of line endings (because 3 different people have been editing the file).


Love
Jens

On Wed, 26 Sep 2012 12:12:39 +0200, Jens Bauer wrote:
> The implementation would be dependent on on how git is currently 
> handling lines.
> Worst case is, if it's mixed CR, LF and CRLF, such as a text-file, 
> that contains all 3 kinds of line endings (because 3 different people 
> have been editing the file).
