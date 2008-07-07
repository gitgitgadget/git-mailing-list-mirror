From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Discard stderr output from git apply
Date: Mon, 7 Jul 2008 21:49:31 +0100
Message-ID: <b0943d9e0807071349u7c35d2fcr5025b2b282f290f6@mail.gmail.com>
References: <20080704063427.9515.68707.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 22:50:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFxfN-0000Yk-NF
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 22:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208AbYGGUtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jul 2008 16:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756159AbYGGUtf
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 16:49:35 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:44711 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101AbYGGUtf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2008 16:49:35 -0400
Received: by yx-out-2324.google.com with SMTP id 8so513115yxm.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 13:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wj2FLX70z/OE2iDPo96397wsOFnvcQ5D2qoEwav/CuE=;
        b=S4G+tpbj156takpDH5mIykVuyvIq6m2QOya3hTlr5Eh+TjVIR8u3ktSpUMoPmcKt8c
         iwZ39b2eQo3GLgSnvydq/IG7JC/joDFoV9D4B9+C+wYO2T8rbmdiHRc5d4nLmDj3js3n
         lu5LOrc+3tGj81PF0W+9Hefuats3GYilhLC2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Vz+rkJprSEEA3jzrRa+t0N6EY1EQiGZNwPgdYp0OVJEpW0Wedowk2LGubkhIpEiUT0
         PdihOJQnAYOBhfVhLcdik8OX9aO9b1N5hHgD5N4EtGC8GaBBXlHzPQJR2Xi9Qve6yaAV
         yq5iU4WwYGJeGI89V6AgjTve9GphhMjUsmULM=
Received: by 10.114.15.1 with SMTP id 1mr7010438wao.184.1215463771742;
        Mon, 07 Jul 2008 13:49:31 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Mon, 7 Jul 2008 13:49:31 -0700 (PDT)
In-Reply-To: <20080704063427.9515.68707.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87653>

2008/7/4 Karl Hasselstr=F6m <kha@treskal.com>:
> It prints error messages when it fails, and we don't need to see them
> since we don't care exactly _why_ it failed.

Are you sure we don't need this? I found it useful when running
"import" to see why a patch failed.

--=20
Catalin
