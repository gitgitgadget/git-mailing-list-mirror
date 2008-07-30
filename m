From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Wed, 30 Jul 2008 17:09:13 -0400
Message-ID: <32541b130807301409t2f1f3a80n44c62447c628f03a@mail.gmail.com>
References: <20080730051059.GA4497@sigill.intra.peff.net>
	 <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk>
	 <E2809CE9-1DEB-48DA-8E42-8BEAB376FED2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Anders Melchiorsen" <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	gitster@pobox.com, peff@peff.net
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 23:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOIw4-0007BO-FK
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 23:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbYG3VJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 17:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYG3VJQ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 17:09:16 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:28853 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbYG3VJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 17:09:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so131473ywe.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QZQub+aSykq5sgWu0ikB2B99jkV97cR0NR0Aj8IJ3hc=;
        b=sTpvuPBxjCXAIDY6VstBT4eNpmOo2apFU+fVe+UIQ49+znto6wRiuNRK64DQg0fWXh
         vEMxVXjh6oIV8PJZZ6d2xz4dXkciA4U4es5kITJnX90urzzL2c9CvpJ2SU3kG5PVR9hF
         rgw+L7wTzZ5oybf9oX/o6IlX28thm+xhVg7TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kJXNLCpPExrxMxusXb/eJbn4S3bOa0vhKx8ZN5dsdLb3i6/EE+2DODnHYisdItbTiZ
         txm9A1lKBQUHO/ZWRFEqfn51Z9u/CKl7O9rwat2gxsl45jsYT59b+HU4cat7HpP+r4f6
         RbMD8DN6s8YMbvferksM7FwVBSpQJHLjsT/20=
Received: by 10.114.184.11 with SMTP id h11mr9269666waf.175.1217452153490;
        Wed, 30 Jul 2008 14:09:13 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 30 Jul 2008 14:09:13 -0700 (PDT)
In-Reply-To: <E2809CE9-1DEB-48DA-8E42-8BEAB376FED2@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90856>

On 7/30/08, Brian Gernhardt <benji@silverinsanity.com> wrote:
>  'git commit' should return with an error any time it does not commit.
> Otherwise scripts could get confused, thinking everything went fine when
> nothing actually got done.  Here, the user decided something was in error
> and canceled out, the same way using using ^C causes a non-zero return
> status.

The patch uses a non-zero exit code, which is an error status.  But as
that's the case, I'm not sure why it's described in the changelog as
treating it "not as an error."

Have fun,

Avery
