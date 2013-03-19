From: Duy Nguyen <pclouds@gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8miBnaXQ6IGhvdyB0aGUgcGFjay1vYmplY3RzLmMgZmluZCB0aGUgbw==?=
	=?UTF-8?B?YmplY3QncyBkZWx0YQ==?=
Date: Tue, 19 Mar 2013 08:53:20 +0700
Message-ID: <CACsJy8DzXWDOXUKxF8Mj9VUWG_rVQpkS=hxrtLYokG10AkjO0w@mail.gmail.com>
References: <tencent_334CD10A3AA16B201938BF85@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?5pa55qCL?= <fangdong@pipul.org>
X-From: git-owner@vger.kernel.org Tue Mar 19 02:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHlkn-0004Nm-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 02:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503Ab3CSBxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 21:53:51 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:40204 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab3CSBxu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Mar 2013 21:53:50 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so6432327oag.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 18:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=kNGtqo/+iXYsxdA73I3ywfNe7R6M4PseB1SyaTwR9VA=;
        b=wYe9nV6s4MNckoHvd+9KZ+pvhn9e5/m/FN7Mn6jQbuxK+BQduYq+Pfcrlx/bD5KYlm
         NGGnxSyxUYVpmZfwXiZKbPk0vDyaKB0AdUb0OE6sOYn7iRjNLojCNmix/z2i+cwQi1qn
         HOXOqkpr7WTq7S7WF8YyjWLctdaA/+ThPAbeUpUIHzGFzbQmTB6yHSe4oxaT3nU36A2b
         uHUbFL2kqboQDTsmDB83PpcKGAg2V9ZWjcVSlnWw0QOLvAsH6QnENs3ASA2/PDXgxQoT
         SZWhPKrHMx/5O9J6g4Usq0e/yWGpYWBCvk2pPziI983XC4BmrKKSf5XNvY7ttA91i3fR
         NPzg==
X-Received: by 10.60.171.167 with SMTP id av7mr156478oec.77.1363658030128;
 Mon, 18 Mar 2013 18:53:50 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Mon, 18 Mar 2013 18:53:20 -0700 (PDT)
In-Reply-To: <tencent_334CD10A3AA16B201938BF85@qq.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218469>

On Mon, Mar 18, 2013 at 1:09 PM, =E6=96=B9=E6=A0=8B <fangdong@pipul.org=
> wrote:
> do you known the delta_data format?
> i want to know more details, thx

check out patch-delta.c:patch_delta(). I believe that function applies
a delta. You can figure out the format by reading how it applies.
--=20
Duy
