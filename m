From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv7 0/9] atomic pushes
Date: Mon, 29 Dec 2014 13:37:05 -0800
Message-ID: <CAGZ79kZc++2Nx1dibJgdn7B703QVkjPfP0cG5_FMCOg3g9R40A@mail.gmail.com>
References: <1419888915-31760-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 29 22:37:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5i02-0002yF-An
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbaL2VhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:37:08 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:63782 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbaL2VhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:37:06 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so11803103igi.0
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 13:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oVWMaGHiEqWQJsQtkf5yCc0bfLQehbixEon2qMEmWxc=;
        b=GLQQ8RPU2zXd61Dvr99gh4TT8UCBwxErIHNGSOq+M8FRLLV7FH19SRInwhvo9gJFPX
         atWr+JzSQZ1uYxu1AonV1D4QVYboihEaOISfBheyXNlqlC2l4rZ4kHha+3VhQpaSbWte
         +3ngQrqXeKYL+g7cVbxcA2+xE+OOZLOr0v00TzOHWgpDplMSrbbAl7kI9hnLycGofM9q
         4d9W19Hez/IuEB1W/OBXqNqwgaxmXTlmyb5cmoyy4iYSVgTa/zEHJRIOvvGf7w94ftDB
         n0WVBX4NFItsaB5b+WfdxSmRp/IHeXFLwwzfIpJ5aouHQgiJsH/S8l7U1mvpfdv0nEJh
         Ix4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oVWMaGHiEqWQJsQtkf5yCc0bfLQehbixEon2qMEmWxc=;
        b=MS9qDVPbI8J9i1L5OVa5tKaBFJCR31BI12Uungi/P5JEwKw8munWdMbxL7P1VIB0hR
         YHpwgAQwFZid43EO5S/u8U+PRPjy6nHKmFz5A/oQrJMiU+R+fa8kLROYQq1hcmWd8U+v
         kOsRFhcuGS4hwKDgXdkHlSShZOBdnn3gxR9WNHvhBnz3hvao444Y279Cz/MWk/u7R4dh
         2+qFxndf1UNcYUVlE6xh2rEYKk87Qt2i2AZ0yMlqfessHUMZajq0lZJNC9TwFrEUPDg0
         7gx/86jxXyx5Y9GckL18RO9TaYfPOjTNf2ecNkhuDvQCO/ZTpgbIIZOhsxv2a1ztpIgJ
         dXRg==
X-Gm-Message-State: ALoCoQlJVSmNXPnP3sCo/uZGkSIbvXNhTvDIO4HBzyxSSoJZnk69csHLWx49MN59jTQg0Zb1o1qV
X-Received: by 10.50.142.38 with SMTP id rt6mr37433969igb.25.1419889025645;
 Mon, 29 Dec 2014 13:37:05 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 29 Dec 2014 13:37:05 -0800 (PST)
In-Reply-To: <1419888915-31760-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261890>

please ignore this series. I'm sorry for the noise.
