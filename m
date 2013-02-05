From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] status: show the branch name if possible in
 in-progress info
Date: Mon, 4 Feb 2013 22:38:47 -0800
Message-ID: <20130205063847.GA3240@elie.Belkin>
References: <1359471493-32531-1-git-send-email-pclouds@gmail.com>
 <1359870807-22817-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 07:39:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2cBb-00034F-L8
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 07:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab3BEGi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 01:38:57 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:41960 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3BEGi4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 01:38:56 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2993310dak.30
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 22:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H6MYg98Qz+Pk+KBooPbwkRvTSSzFzeY/wJKPfAX/pec=;
        b=HO7gI5GjmBwvZ2z1j3OYLBEzTRPtE+P/h4nbNFN3gJPMs/d24UIIHUUsHflNaXyFXV
         eD34LoBk7BP6n0+BMPT141fi0PSOJMwPgduPDYZ1vyiKoPxDRtsz/1ncuRPI/xg57LBn
         4EKYmP6wB0wZcn9e9BsyiFLqirTJVAqVZYkSRBw7caAqW/13RKsrMj3E4eBtFI4Yx4cl
         A8LovhW3BHsb+Ot4fmuQFXMvYVM6jlrF8CYvhw6vSaqHgQ0g1TsvlvatoNRcZvkbtSYx
         ghSBHMsvB4olErsbzczttAEn29A6g22B/OgucOn6Vh3OywlBSIofu7zNljza3dvLhpRz
         4mnw==
X-Received: by 10.66.83.136 with SMTP id q8mr60968697pay.83.1360046336371;
        Mon, 04 Feb 2013 22:38:56 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id a1sm26927405pav.2.2013.02.04.22.38.53
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 22:38:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359870807-22817-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215463>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Missing description.  Stealing from the link you sent:

	The typical use-case is starting a rebase, do something else, come bac=
k
	the day after, run "git status" or make a new commit and wonder what
	in the world's going on. Which branch is being rebased is probably the
	most useful tidbit to help, but the target may help too.

	Ideally, I would have loved to see "rebasing master on origin/master",
	but the target ref name is not stored during rebase, so this patch
	writes "rebasing master on a78c8c98b" as a half-measure to remind
	future users of that potential improvement.

	Signed-off-by: <...>
