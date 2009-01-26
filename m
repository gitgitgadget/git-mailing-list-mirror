From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] Allow format-patch to create patches for merges
Date: Mon, 26 Jan 2009 20:34:02 +0100
Message-ID: <bd6139dc0901261134n1ad61992t64d36135a6756eaa@mail.gmail.com>
References: <1232988212-8613-1-git-send-email-nathan.panike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:35:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXF6-00030h-Gh
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZAZTeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbZAZTeG
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:34:06 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:3511 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbZAZTeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:34:03 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2633183ywe.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 11:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=GEZQ4hCyQthYV89Od/RlDFjySzK0y1AopAV1HP2tDzs=;
        b=sD8B5YhPw4U4l74CIbstPQYzrstJLYMpkwWavYKmGabblcv9bGXzp3aZGU1KJP60kR
         JbJGH7IVwQtQg1pR2POrZn77v0hwWs9TCeipvMdj0hO7BHVUkrA5+1/4aVuU0/i1Ea1O
         PXGtm+pSeXfHMUOcBMg5k2XNF8ZdFFOYm3ICk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=sSgYb7INQcmDusuQrEP6G1cUJTRAOf6ve8+XHFWRc7nbGc+3Nc+1bKAXBWnoBDagen
         EuAOIPpREq8yj8itZZ0OLf8qNgtn2wuUvscxvfeKm4GKgNqs13dV0R2AttSpvm7pY9UE
         oun10GJyJ2dxEnnb9AsdfsqDdSAyPs7IMDCYY=
Received: by 10.151.103.1 with SMTP id f1mr117785ybm.203.1232998442761; Mon, 
	26 Jan 2009 11:34:02 -0800 (PST)
In-Reply-To: <1232988212-8613-1-git-send-email-nathan.panike@gmail.com>
X-Google-Sender-Auth: a1931fc99e6d0430
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107257>

On Mon, Jan 26, 2009 at 17:43, Nathan W. Panike <nathan.panike@gmail.com> wrote:
> This seems to solve my problem, but maybe my workflow is sufficiently different
> that it is a problem no one else has. Maybe someone can point me in a direction
> that solves problems more users have.

It seems like you want to use bundles instead of patches? Since you're
using it just to propagate your changes...?

-- 
Cheers,

Sverre Rabbelier
