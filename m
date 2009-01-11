From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and --prune-empty.
Date: Sun, 11 Jan 2009 16:08:33 +0100
Message-ID: <bd6139dc0901110708u15814e4bl5a3149e68355901f@mail.gmail.com>
References: <20081030132623.GC24098@artemis.corp>
	 <7viqr5wgl7.fsf@gitster.siamese.dyndns.org>
	 <20081103092729.GE13930@artemis.corp>
	 <20081103151826.GJ13930@artemis.corp>
	 <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com>
	 <20090111111800.GA8032@artemis.corp>
	 <alpine.DEB.1.00.0901111433580.3586@pacific.mpi-cbg.de>
	 <20090111142732.GA18484@artemis.corp>
	 <bd6139dc0901110640l148b00dctd667572e28908f9f@mail.gmail.com>
	 <20090111145537.GB18484@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	pasky@suse.cz
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Jan 11 16:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM1wv-0006rO-ON
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 16:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbZAKPIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 10:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbZAKPIg
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 10:08:36 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:62522 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbZAKPIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 10:08:35 -0500
Received: by yw-out-2324.google.com with SMTP id 9so3292751ywe.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=E8pdjCCRHw8uRpdTwN2JSaHCPWxEpz5eivQR34HqsFE=;
        b=nSblev0tKv6ce4zazWF6xSdvnYknAkkH4Tk4dDKdbSkCXwOTTTAxfensmxyeKQtI76
         dzDaVodELtF0CB6LUap/AicViTSlSXufE1r9TEU+ob1KTN1PgBxXXqVHaYZtkvcFL7UP
         IJYIpY6g/JS2t+M9msuPwVnh0SlQ6tFbVMHrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=pxtixSnAJk/usAgobV6sJkJ8sdwLs21yGouP2MFE++WhBkECcLGXIk23J3S5gzi/1v
         fn1U1Bjba2qm5tdyHcJyDNEjcatlJAJ/zrTndB193MzbCcrNqvvfe2ov1XYc+VO6+XzH
         C5m7dmqlJz8C7YpqcDHUvmMu8/Gk24UT3z82o=
Received: by 10.151.141.16 with SMTP id t16mr8435915ybn.248.1231686513847;
        Sun, 11 Jan 2009 07:08:33 -0800 (PST)
Received: by 10.150.198.12 with HTTP; Sun, 11 Jan 2009 07:08:33 -0800 (PST)
In-Reply-To: <20090111145537.GB18484@artemis.corp>
Content-Disposition: inline
X-Google-Sender-Auth: 15645c64e6759cc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105188>

On Sun, Jan 11, 2009 at 15:55, Pierre Habouzit <madcoder@debian.org> wrote:
> No I've found it, it was sent by Petr which explains why I didn't find a
> mail from _you_ :P

Ah, yes, that's right :).

> Will sent a patch reworked to have a special paragraph the way you
> wanted, but using my additions instead.

Ok, nice!

-- 
Cheers,

Sverre Rabbelier
