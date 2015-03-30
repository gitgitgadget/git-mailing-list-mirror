From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git ls-files wildcard behavior considered harmful
Date: Mon, 30 Mar 2015 16:24:24 -0700
Message-ID: <20150330232424.GD22844@google.com>
References: <20150330230459.GA13927@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Mar 31 01:24:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycj2n-00008U-3d
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 01:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbbC3XY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 19:24:28 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36924 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbbC3XY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 19:24:27 -0400
Received: by igcxg11 with SMTP id xg11so3261906igc.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 16:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jdX2yIQpxSkyrpnZmqrQylbCClquwymolWdjBPbJDJE=;
        b=trHLo4zsTB5uO2ChKDBuBy7P/v4Y84FfkobhXajuLWsZKeonw8X0daj/3LIURWH+/s
         C79kZs0pfeRsJXkxglpvNDzAwJHHESF3MbAEXZgfLEcgVDoLiYjtJWTWr9+JB+wqzTiO
         nioi1kD3M+3wYh+u66QbeZTP8xG4iM1KvIpefhnSoeC4i9ax9A+hQpzuF21y4cFjCRpl
         +3GI6GqI8NKkx8xFaFuhPHsYJ5GCss7kRpoW/XHOvCGQ6wJumm+XeUqxrUOxREYCXFJm
         lrMdGeZezK5P8ED8feidSEa0bPg2Q4W0v5SzcvnW294XVZ2b0nYItv6qmCQeJhImmH4O
         oQ2A==
X-Received: by 10.50.56.20 with SMTP id w20mr206200igp.43.1427757867158;
        Mon, 30 Mar 2015 16:24:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b8c3:e0dc:7bee:9947])
        by mx.google.com with ESMTPSA id u19sm2467148iou.18.2015.03.30.16.24.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 16:24:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150330230459.GA13927@kitenet.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266488>

Hi Joey,

Joey Hess wrote:

> Since I wanted to avoid this wildcard expension, I tried slash-escaping
> the wildcard characters. This works:
>
> joey@darkstar:~/tmp/aaa>git ls-files 'foo\*bar'
> foo*bar

Does 'git --noglob-pathspecs' help?

Curious,
Jonathan
