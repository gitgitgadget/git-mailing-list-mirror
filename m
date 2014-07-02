From: Avi Kivity <avi@cloudius-systems.com>
Subject: Re: [PATCH v2] git-am: add option to extract email Message-Id: tag
 into commit log
Date: Wed, 02 Jul 2014 16:54:12 +0300
Message-ID: <53B40F04.8000304@cloudius-systems.com>
References: <1404291113-4424-1-git-send-email-avi@cloudius-systems.com> <53B3D7AB.6090207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 15:54:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2KzT-000766-9d
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 15:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbaGBNyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2014 09:54:19 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:60932 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbaGBNyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 09:54:16 -0400
Received: by mail-we0-f169.google.com with SMTP id t60so11352837wes.14
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 06:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wR9/Q8n9akOthZ+1uzhScLywVfse6I3SagVqyvUipHE=;
        b=AkzyDom5msPOevltCs/n/PO+m9ymTBdyN6S0Rqd5MwDP2GaVAo6BJfpjyBZFTAlL3L
         /1sXlhN35F2LT5kKNK4MRr6/RuFSuS1USPVU/Ic5xfGUAxrOrho9Md3oJPew0kY8TmCx
         GH7aSsGUun4wpax/bBAaNMDQ61syr90yMX58ge0deX8z0DKesMQnWYwPhK42X6dV7bqj
         PvRa9JcI+bkXsLVUXaBfPLvhx5MIMYOiHjEoFFk5SI0NXi/0g73xX5fIQWpPJNybWdp6
         jYx5M8yjh8uoMN029ShOFPGJd5NUToOf25bFrl2uIZcDVdt75j8fmUvaoTLJS7c9oxwv
         eKHg==
X-Gm-Message-State: ALoCoQl97tz1Bq9nLbkOzeYR09Wuuj5atKBlQdh5w2vBE9aCZCFVv2fShdsGWKkBiwwuUub3XAAg
X-Received: by 10.194.133.1 with SMTP id oy1mr19322582wjb.87.1404309254482;
        Wed, 02 Jul 2014 06:54:14 -0700 (PDT)
Received: from avi.cloudius (84.94.198.183.cable.012.net.il. [84.94.198.183])
        by mx.google.com with ESMTPSA id 10sm43525039wjx.26.2014.07.02.06.54.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 06:54:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B3D7AB.6090207@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252779>


On 07/02/2014 12:58 PM, Torsten B=C3=B6gershausen wrote:
>> @@ -757,6 +761,10 @@ To restore the original branch and stop patchin=
g run \"\$cmdline --abort\"."
>>   		then
>>   			cat "$dotest/msg-clean"
>>   		fi
>> +		if test 't' =3D=3D "$message_id"
> The =3D=3D is bash special, please use =3D instead
> And the 't' can be written as t, so that the whole line looks like th=
is:
> 		if test t =3D "$message_id"
>

Thanks.  v3 posted with these changes.
