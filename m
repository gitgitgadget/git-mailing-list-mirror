From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3] Allow HTTP user agent string to be modified.
Date: Wed, 11 Aug 2010 16:04:02 +0800
Message-ID: <AANLkTim1=Sa++uabphu03gv4i+JakoOhxf1w91WLB4sd@mail.gmail.com>
References: <AANLkTi=G=GvxXEh1hGuYQK42cdkMUaFhqxsQ39K=2180@mail.gmail.com>
	<1281504288-31836-1-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:04:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6IL-0003VC-RY
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab0HKIEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:04:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44243 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429Ab0HKIED convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:04:03 -0400
Received: by eya25 with SMTP id 25so4244323eya.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QqNNtH1mmbko8ud2bX96mv0+kbGdFp9il7E+vFKiXtQ=;
        b=WD1X6gEiUY+7D7O5tRP3HqS1NGKwuzKwWvSZqS8exjWQAs7eYpyW9JggKgFj0vqYW8
         wwtj5/ksQJU7lDgMu9lbhxZ9205zPmbuwzxttcNnBDGECYVbddWUPSS4MU0P7vIHIRb0
         PP2sG3OIj2a6o5Ri8dxQTa1QbLJrKKeuXyCY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H0lHzaB3DWw4c9BGdYfyNp3wuuLZG1lMHaq/AwL/UHSJCBL2w7u6RCKncpb/Fd7q3i
         6lt2vOUvKsrpPNdwFV4z37CNbgJl2SaG7U/uexyDGeKtOVXOynm/t2ZPjP/WBp1rqmOv
         dUVAPR+NzChkq/H32iQ1Gaz3pxKFiagwM5jwM=
Received: by 10.213.19.67 with SMTP id z3mr5453285eba.87.1281513842474; Wed,
 11 Aug 2010 01:04:02 -0700 (PDT)
Received: by 10.213.15.72 with HTTP; Wed, 11 Aug 2010 01:04:02 -0700 (PDT)
In-Reply-To: <1281504288-31836-1-git-send-email-olsonse@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153198>

On Wed, Aug 11, 2010 at 1:24 PM, Spencer E. Olson <olsonse@umich.edu> w=
rote:
> Some firewalls restrict HTTP connections based on the clients user ag=
ent. =A0This
> commit provides the user the ability to modify the user agent string =
via either
> a new config option (http.useragent) or by an environment variable
> (GIT_USER_AGENT). =A0Relevant documentation is added to Documentation=
/config.txt.
>
> Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
> ---
>
> Hi all,
>
> This is an updated version of this patch including the changes sugges=
ted by Ray
> Chuan.

  Acked-by: Tay Ray Chuan <rctay89@gmail.com>

--=20
Cheers,
Ray Chuan
