From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 14:21:03 +0600
Message-ID: <20150625082059.GA9937@alex-host>
References: <1435217454-5718-1-git-send-email-cmarcelo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: cmarcelo@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 25 10:21:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82PP-0004fu-Vo
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbFYIVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:21:16 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:33832 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbFYIVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:21:12 -0400
Received: by lagx9 with SMTP id x9so40269755lag.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0dWembm3D8odcO2rZg/FOjgUQziW8WX+jAFmJqQjwEY=;
        b=HSWqD8PC3i6DEU5w14ujFhBwzEwUeAwEDuGYyTM1IDivzUMBPxGP3sJc7/SNPSRL7m
         DE7bRQTCqIiovRMCuXXa7rHEzFHkpAfhuupYQf9DYtgD8+iIZZS99ybHTxdgRRJFi7hf
         HaiXpnrovh4JRdesEQ9ZfFXAa4H07/MBOhuIfeek0KjU+3Gl0XDzEENZlW8Nep3/ubId
         6B383CTZanufO1ZzwKjA7ZKEJfuSo1dyQk6xIoKsLn+jFvjEDJIK4koYLw027QMS3QEl
         Ar4DqzQky4H8o56FksKUlS4x5pElTsKXesHeXltOt7w/+ePoiUBprYPm5OjM4YGqSME8
         YFrA==
X-Received: by 10.152.43.134 with SMTP id w6mr41872935lal.120.1435220471520;
        Thu, 25 Jun 2015 01:21:11 -0700 (PDT)
Received: from alex-host ([147.30.51.129])
        by mx.google.com with ESMTPSA id rl1sm5567606lac.14.2015.06.25.01.21.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 01:21:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435217454-5718-1-git-send-email-cmarcelo@gmail.com>
X-Operating-System: Linux
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272637>

On 06/25, cmarcelo@gmail.com wrote:
> From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
> 
> In projects that use Signed-off-by, it's convenient to include that line
> in the commit by default. The commit.signoff config option allows to add
> that line in all commits automatically.
> 
> Document that this config option can be overriden by using
> --no-signoff.
> 

Hello, also would be great to have bash completion for the --no-signoff

Thank you.
