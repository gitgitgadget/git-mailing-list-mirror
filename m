From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Thu, 30 Aug 2012 19:51:02 +0200
Message-ID: <CAN0XMOKar3jdDMfY=rRkcmNy0i0zKMuhBQ=Z4bi=eus_xAFWyA@mail.gmail.com>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
	<1346347393-8425-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 19:51:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78td-0001Ct-81
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab2H3RvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Aug 2012 13:51:06 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57616 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab2H3RvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2012 13:51:04 -0400
Received: by wgbdr13 with SMTP id dr13so1760564wgb.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2012 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=p46JCDFjlBQ2trukrvPAGDtcl51MSFGEvJMOYO+7L5g=;
        b=f6ptQm2HCNYeuRkzofkyyT/PoTJJwTHhV+7nAsgJex2QDkZlctFz2kvQH3v4TLSuVY
         66DouMSQZ4tr8qDzq/5eNyQaisCG2JUnx8tcYq1C08w2mgwbv34J42u4+wXIQ7QZ2+ND
         kVaePurB4fB7ekmutriV7ZQPM74KCtfXkaMBNZyDgmKs+s6gx5NZ3Wf5fwO7kwLGffBB
         mwIzWEyRxfHaT3QbAF8KX1BLherE5Ej5JkVlJ4hwlJEAPWV43RqRZqb1evEcLGbTmh7y
         wFqg3RV5FH5z3+rx6t/okbSDhRsm/LwLgLVAiLILK20kQSSBFnwK0kcxyL9tVPFk2vrt
         duhg==
Received: by 10.180.104.200 with SMTP id gg8mr2101852wib.14.1346349062783;
 Thu, 30 Aug 2012 10:51:02 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Thu, 30 Aug 2012 10:51:02 -0700 (PDT)
In-Reply-To: <1346347393-8425-2-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204560>

On Thu, Aug 30, 2012 at 7:23 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> behaviour. To work around this, introduce --set-upstream-to which
> accepts a compulsory argument indicating what the new upstream branch
> should be and one optinal argument indicating which branch to change,
> defaulting to HEAD.
>

Could you please also add this new option to the
"contrib/completion/git-completion.bash"
script?

Thanks!
