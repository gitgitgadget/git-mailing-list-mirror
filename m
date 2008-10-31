From: Steve Folly <steve@spfweb.co.uk>
Subject: Re: [PATCH] Avoid using non-portable =?utf-8?b?YGVjaG8=?= =?utf-8?b?LW5g?= in tests.
Date: Fri, 31 Oct 2008 09:36:03 +0000 (UTC)
Message-ID: <loom.20081031T093317-846@post.gmane.org>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com> <1225429753-70109-1-git-send-email-benji@silverinsanity.com> <7vtzat89br.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 12:11:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvruT-0005mK-K6
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 12:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbYJaLKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 07:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbYJaLKH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 07:10:07 -0400
Received: from main.gmane.org ([80.91.229.2]:40494 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbYJaLKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 07:10:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KvrtC-0002Gx-Kq
	for git@vger.kernel.org; Fri, 31 Oct 2008 11:10:02 +0000
Received: from 80-195-8-231.cable.ubr16.haye.blueyonder.co.uk ([80.195.8.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 11:10:02 +0000
Received: from steve by 80-195-8-231.cable.ubr16.haye.blueyonder.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 11:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.195.8.231 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; en-gb) AppleWebKit/525.18 (KHTML, like Gecko) Version/3.1.2 Safari/525.20.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99575>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Brian Gernhardt <benji <at> silverinsanity.com> writes:
> 
> > Not all /bin/sh have a builtin echo that recognizes -n.  Using printf
> > is far more portable.
> >
> > Discovered on OS X 10.5.5 in t4030-diff-textconv.sh and changed in all
> > the test scripts.
> 
> I had an impression that OS X was BSDish.  Wasn't "echo -n" a BSDism?
> 

FYI, "man echo" on OS X 10.5.5 has this to say...

     The following option is available:

     -n    Do not print the trailing newline character.  This may also be
           achieved by appending `\c' to the end of the string, as is done by
           iBCS2 compatible systems.  Note that this option as well as the
           effect of `\c' are implementation-defined in IEEE Std 1003.1-2001
           (``POSIX.1'') as amended by Cor. 1-2002.  Applications aiming for
           maximum portability are strongly encouraged to use printf(1) to
           suppress the newline character.

     Some shells may provide a builtin echo command which is similar or iden-
     tical to this utility.  Most notably, the builtin echo in sh(1) does not
     accept the -n option.  Consult the builtin(1) manual page.


Regards,
Steve.
