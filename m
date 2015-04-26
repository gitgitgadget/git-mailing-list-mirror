From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 Question
Date: Sun, 26 Apr 2015 23:27:15 +0100
Message-ID: <553D6643.5020100@diamand.org>
References: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>	<553552FD.80703@diamand.org>	<CAFcBi89pXTKzeVkB5EN3ZYkLwa1oPfDOqdHHhHeVogswhnpOAg@mail.gmail.com>	<CAE5ih79L+RU934OYsBrXjP7PAoDYbeBS01hCgsOm+pnFD+dWwQ@mail.gmail.com>	<CAFcBi88ZohscEZXVXbaf+6=ZKJAy9LRfn2-4WT0JV+1RodBTJg@mail.gmail.com>	<553A0ACF.4000006@diamand.org> <CAFcBi8-GGxrtm+f7NEf0PmWTkS0m6x2fNPt+y4bopqNLfyvyoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: FusionX86 <fusionx86@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 00:28:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmV1y-0000Ku-VK
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 00:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbbDZW1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 18:27:49 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34190 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbbDZW1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 18:27:47 -0400
Received: by wgso17 with SMTP id o17so98615664wgs.1
        for <git@vger.kernel.org>; Sun, 26 Apr 2015 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CuNMDP7VUboqkAdDIMXAB8W325qjwFnj5SNmsexTq8c=;
        b=Ee7y/HYgyDlmxPpxvMYKZLNBbajZn6e44wLWUAllwgy74Jq8tf6Cxl8N+hNz9nKgsd
         mgn+UCYPFJQfcnBTL0Z4a8LKOqZijY/acvU+qdb7de/qI1KUAyuRkIKpCaGUfTRuHF+z
         Hqd1CxRSrNCt7t7s8+d18DRAzWwPg/pk6qWtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=CuNMDP7VUboqkAdDIMXAB8W325qjwFnj5SNmsexTq8c=;
        b=Bekbvv4XYvdA8D1D8rZXz92EZ9bAOCTkMBThHd2oy4Zxl1a+xFkOpFWUx+AkJ95Zva
         Z+cbgaYAZEiQ/1zMEU92GqKW4MBpoGJQsMweY/E0dFXh7eGab670V97PYgSJjG5u0e6b
         1dHH6XL6QT0B+Sk4X0drUFnQGsOnvpE+iWI293vYOEfrIbyiW8RM6qwx0gAtpxecgxnF
         wp75I4ehTfIoMOCqjZ1w+f1mG+fDMkYyfCSr0DtQCKuv5zWz6WZwmysIQuGoyZBdweeD
         +5VbhoGhohPJGzJLDMhDQGD62+wjNKNQYCYcjQWyTcKzbaa/tSdfwQ8vBDGCzTdkZif6
         E9cw==
X-Gm-Message-State: ALoCoQlndtCoQippl2BoVkBWl+99wL/H/tA/ePS5jWwHn4l8QsftEBSfmsHq+IDxwgTuP7bvsIt1
X-Received: by 10.194.90.106 with SMTP id bv10mr17401732wjb.122.1430087265822;
        Sun, 26 Apr 2015 15:27:45 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id mc20sm8987212wic.15.2015.04.26.15.27.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Apr 2015 15:27:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <CAFcBi8-GGxrtm+f7NEf0PmWTkS0m6x2fNPt+y4bopqNLfyvyoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267842>

On 24/04/15 15:36, FusionX86 wrote:
> I get an error if I misspell part of the path. For example, if I type
> //depot/maain instead of //depot/main I will get the "no such files"
> message you indicated. BUT using incorrect case like //depot/main
> instead of //depot/Main doesn't return any error, but still completes
> and creates an empty repo. If it does require correct case, then it
> should throw an error for //depot/main as well.

Thanks, that's a somewhat subtle bug....!

Luke
