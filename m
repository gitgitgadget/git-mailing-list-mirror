From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 1/2] cmd_clone: free dir and path buffers
Date: Thu, 31 Mar 2011 10:45:07 -0400
Message-ID: <AANLkTi=XYv1WFbvHwqvrJDkssKC-zU91Vj4EPbZG6OK2@mail.gmail.com>
References: <1301581122-19947-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:45:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5J7c-0000rZ-KI
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 16:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725Ab1CaOpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 10:45:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53324 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab1CaOpI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 10:45:08 -0400
Received: by ewy4 with SMTP id 4so754391ewy.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1Hjv6A+acQ8F1lIifjNd0fRUN3KAlQCEZBbStuICLx4=;
        b=lkovGPyWbRwdM2G+yGDFk90Ca77OtWRX7xu8mIv5GpQ0fFv6iHKSW7/kdnO0Ft8J+u
         5oEuhHv2f0xxxuKAsJNJlUsUmEJaelKZGm1/z/gK9Tyw0frZmtMSFpcW2jzHylxqriMv
         mVOfQncFnB/WWWz4tBWhU0Us/bMrDO3tMBYTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Ekuzfjpbib2R+y02zz761xE27Ab9Nbu0parIQbiU77nQ33YV2+m6fhtH2odJbnXS90
         nzSoVnHwWSPtUvL0k467vj2WrtiFDybIkhSpzGi4Ns6rOyNcp1sdGsVya3M1QJqaRdgn
         j3GZNxAHUn0JVdvCidmKY8wpQgqbDUXuIytlo=
Received: by 10.216.143.135 with SMTP id l7mr1112547wej.86.1301582707209; Thu,
 31 Mar 2011 07:45:07 -0700 (PDT)
Received: by 10.216.182.209 with HTTP; Thu, 31 Mar 2011 07:45:07 -0700 (PDT)
In-Reply-To: <1301581122-19947-1-git-send-email-cmn@elego.de>
X-Google-Sender-Auth: R4Wo-UOo6nMypm9pVnQRAkIc7-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170495>

On Thu, Mar 31, 2011 at 10:18 AM, Carlos Mart=C3=ADn Nieto <cmn@elego.d=
e> wrote:
> The variables dir and path are always allocated on the stack so it's
> always safe to free them.

I think you mean "on the heap". :-)

-John
