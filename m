From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Git detects changes after new branch created and switched even
 though files have not been changed
Date: Wed, 06 Aug 2014 18:02:06 +0200
Message-ID: <53E2517E.8020301@gmail.com>
References: <a2546f9109674431820b7a98f9570433@BL2PR05MB180.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jared Brank <jared.brank@skaletech.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 18:02:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF3fR-0000Ym-Jp
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 18:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbaHFQCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 12:02:18 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40992 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbaHFQCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 12:02:17 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so9884646wiw.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=zyQcwpRohKvu+w8xR17IeMHZpsba27RkqycEnOzHE6s=;
        b=bFOZQprn77/a6+j7ApHN5wlFZI3J4CgZmPDopozsj6J9V4OqCCkoi/Z+pT1cCH4qc7
         PkKBbqTif5A85Bipj5vd/Yq+tYrOpJDEJa81zPvW1nyo67ZpmfbAM4IkWFJ5nFfCzTTV
         bOh4Hl2c5S4Swt5G9nakr8Cgg7bdE30CGrYLyj5WOTBfcyOasTUsEYuMwJR0MDQB7lzG
         D0G+EMHIQTpSFjVtbp1fd+gScBuFcrHqAJa/XI1iMJ7sk9d9Vbe0c55hTd2IiIFKcgl8
         wNEe6/Ip3Ql/lo3oi2YgX9UErZRWFiOxA5zet60i7dLoP4Cudm5aYO+7ajHPaHZgnzYZ
         zrxA==
X-Received: by 10.194.142.200 with SMTP id ry8mr15228460wjb.37.1407340936167;
        Wed, 06 Aug 2014 09:02:16 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id lg7sm3398374wjb.9.2014.08.06.09.02.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 09:02:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <a2546f9109674431820b7a98f9570433@BL2PR05MB180.namprd05.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254874>

W dniu 2014-08-06 17:04, Jared Brank pisze:
> Running on Windows with latest version of Git. 1.9.4. Also had this
> trouble with 1.8.2 but upgraded hoping it would fix the problem.
>
> When I do a reset on several files, it says they were successfully
> reverted they still show up as modified when I do a git status. In
> this case it's just a newline character at the end of the file.

The problem might be the options (gitconfig and gitattributes)
affecting how Git deals with end-of-line characters.

--=20
Jakub Nar=C4=99bski
