From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: simplify file filtering
Date: Mon, 13 May 2013 10:36:02 +1000
Message-ID: <20130513003602.GA8046@iris.ozlabs.ibm.com>
References: <1367100099-13798-1-git-send-email-felipe.contreras@gmail.com>
 <20130511094258.GC6196@iris.ozlabs.ibm.com>
 <7vmwrzu7vt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 02:36:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubgkd-0002sg-BD
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 02:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab3EMAgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 20:36:10 -0400
Received: from ozlabs.org ([203.10.76.45]:55049 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052Ab3EMAgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 20:36:09 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B5E482C00A8; Mon, 13 May 2013 10:36:05 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <7vmwrzu7vt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224072>

On Sun, May 12, 2013 at 03:54:14PM -0700, Junio C Hamano wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > On Sat, Apr 27, 2013 at 05:01:39PM -0500, Felipe Contreras wrote:
> >> git diff is perfectly able to do this with '-- files', no need for
> >> manual filtering.
> >> 
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >
> > Thanks, applied, with the commit message expanded to say that this
> > makes gettreediffs do the same as getblobdiffs.
> >
> > Paul.
> 
> Thanks; is this the last one for this cycle and is your usual branch
> ready to be pulled?

I'm still deciding whether to put in Martin Langhoff's patch with a
modified label ("changing lines matching" rather than "with changes
matching regex").  I'm leaning towards it but was waiting a little to
see if anyone had comments on the wording.  I'll decide by the end of
today and send you a pull request either way.

Thanks,
Paul.
