From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 10:20:39 +0200
Message-ID: <8D224433-C589-433A-B3D7-1073508A6EBD@gmail.com>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com> <3b57e4f4-afba-bb94-2c59-a9ff5765748d@atlas-elektronik.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: stefan.naewe@atlas-elektronik.com
X-From: git-owner@vger.kernel.org Mon Apr 25 10:20:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aublA-0005Tw-A2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 10:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbcDYIUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 04:20:44 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37165 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbcDYIUn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 04:20:43 -0400
Received: by mail-wm0-f51.google.com with SMTP id n3so114591333wmn.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qazo9Trwx8sGi9BGYa/Me4vEV250lpTIKS8SmemKRCo=;
        b=AnXcC/207LSqPpqmNxrdyQfpluHOCKTWRA38E9SXl3TNn06FLrVGNAmdM3zI4Pw4P0
         mqWPIuYqEfan1CZqvZKjgC6C5hPRYrnQYLbZ6gWpCYIpW8D1jyne7WOh/mQBHpCwsXyx
         YMmV+HrEtzCIpj9RT4286P0sOJq9e+Y4DZ43rbRe1ZWruVOI+bE6YlgdxBvTPjL31ixR
         hzEjXZTB0FSjwMHTAQRY69AssBHlOcjol+utQLoj4ND1sjBU9joCI4ro74eDB5EshwOC
         CKIA3ctUaXR8Rp2ssCjfuOpERsTXZhD6WxcbFBqmUE0/9cJmE2qlN7hymlUunoHoOy5e
         v3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qazo9Trwx8sGi9BGYa/Me4vEV250lpTIKS8SmemKRCo=;
        b=glLdRYQ5Lw38PKXymOsgxuGj0OXMMuoQfJM0DCrz0KOfbgMtlqW21hn7CGcTjVxDSG
         dNrHwahXMfJMi77W3WT05JOtxfM6jN8GgumuqOcG0JqI6CMutszrHGExUx59ylqasAFN
         cLGhjCXB3VUJri5sMR+oi3yzcA7YiQc+5fp1h2v5kz/v5whPYNkVpEbcq3muRPYqwxAp
         gVS8gAgItBNKFQDv8pjLI06KIk+/zNkTytgK7VwHlhcGFdIHUozDWERkASfiKLI2IBkA
         zR9OnojV+wIiPm3d93dBYPTDs02AZs8hNFHzSiTXSVvgTZqW4kjAgbUBS+hVctCltDHD
         OR7A==
X-Gm-Message-State: AOPr4FVvxMpFA7NcYF64tIRqhsXD01c4QmRv2dqMJ7xLg02171tBOuJVKniKYOgvvT020w==
X-Received: by 10.28.23.10 with SMTP id 10mr10730371wmx.6.1461572441841;
        Mon, 25 Apr 2016 01:20:41 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4886.dip0.t-ipconnect.de. [93.219.72.134])
        by smtp.gmail.com with ESMTPSA id a207sm12610281wma.8.2016.04.25.01.20.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 01:20:41 -0700 (PDT)
In-Reply-To: <3b57e4f4-afba-bb94-2c59-a9ff5765748d@atlas-elektronik.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292457>


On 22 Apr 2016, at 12:45, stefan.naewe@atlas-elektronik.com wrote:

> Am 22.04.2016 um 10:34 schrieb larsxschneider@gmail.com:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Run "make doc" to check if all documentation can be build without errors.
> 
> s/build/built/

Fixed. Thank you!

- Lars
