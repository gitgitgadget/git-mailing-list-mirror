From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2] t/t7502 : drop duplicate test
Date: Fri, 11 Mar 2016 10:39:15 +0530
Message-ID: <CAFZEwPNqzvAMmkhaRUOsp_Hg-2+rG1Mmo0t9_v4x3md-z8mekA@mail.gmail.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
	<010201536326c56b-cd751f0b-f03f-4c9f-b834-20cee14b6eb5-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 06:10:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeFL8-0005Ga-Vh
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 06:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbcCKFJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 00:09:16 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34282 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbcCKFJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 00:09:16 -0500
Received: by mail-yw0-f195.google.com with SMTP id f6so5558793ywa.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 21:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jI3VBVQTGNg4uepynBEYbsuaoVZwXITOphej5K2SGTo=;
        b=rWiokQOAlI65L2HRyG/4n2dgmJxpyPMG/Hap59/QzXTU2ZcaTn5hG5DVnZJk8mg6lf
         2W/q9dMPmtOcylsgnxkRvoqotfpjFaNuZ/32LBAZ8Ec2zJNLHtiE3lTk60PBwweURh5v
         gO5St2IZ7E62beGfclnXgTcskgQGr6fjOLC0zFvUmdS63PLLesvQlXkYYGS3JihHD2Ph
         OkqZ9wY9yd5ipmi0koN8jPOqY1VjSrUbX6v68QRhSqnQ3vPdEhmNfgMzsNhORrA2I9yx
         nT3csSPbvEUSmQ3cQnSUOlURKCSl+q7ivLpVkKNtRYyqf+ZQ0u/brwA5bmi9PgGUemnM
         E20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jI3VBVQTGNg4uepynBEYbsuaoVZwXITOphej5K2SGTo=;
        b=gy6pvXfaQF/KjdrdlpdOsD56mj3HIDb9QIUoBeI8g++kuJ8lWAnR32Vd1EzV6R5Ynl
         etaB8H1Hc0vEe3yfVVfaucF1ELFH5HcgAbvj4AYfg8/GIrtwTe51+pwWViukmXXJPEe/
         dUpEx/peHRY9g9fZGXDltgvrCyoK0cJ3y8Ia/bmFDCb9GxqUOiF+oO9GatPBNvXc/aHy
         B5PZWSrtlv863BAiXH4vDN9KnTOuwEeGW6MHFlplwjFbC/QX8X1lLVLFU+1uI3onVlYn
         1QS3F+94198NZbnmInkTNSgZhVBo+VI+PoeJU3RgXwZ3otbZ6xAxZxfrkXaHNHMMwsHm
         nf9g==
X-Gm-Message-State: AD7BkJLrMJOZPRaU7FCr1fqADbWG7Gmn048UEKfTe4ujzt2F6Tw3qYI7bdjwGVIDiHFZ2AiGvM9Eqe84Mc72Sw==
X-Received: by 10.129.94.7 with SMTP id s7mr4279027ywb.93.1457672955102; Thu,
 10 Mar 2016 21:09:15 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Thu, 10 Mar 2016 21:09:15 -0800 (PST)
In-Reply-To: <010201536326c56b-cd751f0b-f03f-4c9f-b834-20cee14b6eb5-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288673>

The older version of this patch :
 - [v1] http://thread.gmane.org/gmane.comp.version-control.git/288662

The changes between the patches :
 - Improved the language construct of the commit message
 - Provided more details about the cited commit in the commit message

Regards,
Pranit Bauva
IIT Kharagpur
