From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Move git send-email cover letter temporary file to $GIT_DIR
Date: Sat, 22 Dec 2007 18:04:03 +1100
Message-ID: <ee77f5c20712212304s598d344dg41d03f58084d794e@mail.gmail.com>
References: <7vhcic9e17.fsf@gitster.siamese.dyndns.org>
	 <1198284202-20666-1-git-send-email-hendeby@isy.liu.se>
	 <7vmys3358v.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20712211718g230802b6jb70e5db1f6a43973@mail.gmail.com>
	 <7vhcib2phi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gustaf Hendeby" <hendeby@isy.liu.se>, luciano@eurotux.com,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 08:04:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5yPf-0002gT-Jg
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 08:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbXLVHEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 02:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbXLVHEG
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 02:04:06 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:11889 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbXLVHED (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 02:04:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so704368rvb.1
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 23:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lPRf4ZpMbfjX0t1/8nccz2N42xqDQAVZ49k2GEPGzlg=;
        b=ICh/k/XF3v8OA+IehJtHCnP/l+GXQ+FWVNlOd6qcZ1afIBxKumlnu/YHfaUgGRm4CVtWG7i83oc6w5bt5Pz22yDX65HNDMpAMhQlsWQZm2mZZEa8RWH7mux3MJ3KqMRf4vqJ16AUn6cGh+XSjwlMpl2Fy/vHUWb/aQuaKNnvMvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KSjUxPb154zWdXG5GyS7l2ODt8mkormRYe5ppIb59HRgrlar07Kmc5mMr0x1XFoyvoBfDHduOeHxT06ARtbzkuwOwPEA3JmSYUMfMvS29+2H76s9mou0nWZupkrLKWsXZr8MXm4gYckDdTFeFkISvJfNMYeQqoClyhs0WpvEQbc=
Received: by 10.141.33.21 with SMTP id l21mr1227780rvj.140.1198307043079;
        Fri, 21 Dec 2007 23:04:03 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Fri, 21 Dec 2007 23:04:03 -0800 (PST)
In-Reply-To: <7vhcib2phi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69122>

On Dec 22, 2007 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "David Symonds" <dsymonds@gmail.com> writes:
>
> > On Dec 22, 2007 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Don't you have $repo (an instance of Git) at that point?  You
> >> should be able to ask repo_path() about it, shouldn't you?
> >
> > Isn't git-send-email still useful outside a Git repo?
>
> Then why does it run "rev-parse --git-dir"?

I'm suggesting that it should still function just fine without being
inside a repo, so it should adequately handle "rev-parse --git-dir"
returning 128.


Dave.
