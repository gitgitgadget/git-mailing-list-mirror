From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] test-lib.sh: unfilter GIT_PERF_*
Date: Wed, 16 Jan 2013 10:54:16 -0800
Message-ID: <20130116185416.GA28866@google.com>
References: <1358257856-3274-1-git-send-email-pclouds@gmail.com>
 <1358331833-8289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:54:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvY8L-0008EB-L6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab3APSyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2013 13:54:25 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:63059 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab3APSyY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:54:24 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so882398pbc.18
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 10:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TNeKgkJc2OdjqQOWPyeET011cg50sKw3cmPHuedS3vw=;
        b=VruwFOL6OfMioO6VgnhHrzx21Uk25bdWfTHJ+G4EUYRbCCe36cFl2jTD4AaspG26WY
         vk3DXPNNYnD2UzbfF8qvcxdL9BN/uLq3Zf/KZ5ok89adhmdcHnaX6KOubPhXqhVNKF4z
         vfGJbHXSeaG3aUBL9GHk+cf3+N2TllgQY3mHsS1RdfmFqdPgf8Vr/axelMaCQgy0rsyi
         A5HuYPxU1LMp342fX9CpqbkF2hVyXZqv86UOHO43SBwZVgt6e4ENKswAV35Ut1cbk1Tr
         MtpmeSQjRJyUuXQKkuc6sc3rIWUnrpsv/5grSadLPZeDB17Oq+kgW+QSK8x5oyW4uA/u
         3/pg==
X-Received: by 10.68.135.40 with SMTP id pp8mr5518714pbb.63.1358362464447;
        Wed, 16 Jan 2013 10:54:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id a9sm13447482pav.24.2013.01.16.10.54.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 10:54:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358331833-8289-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213798>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> These variables are user parameters to control how to run the perf
> tests. Allow users to do so.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

=46WIW, of the three versions proposed, this one makes the most sense t=
o
me.  Looks good.
