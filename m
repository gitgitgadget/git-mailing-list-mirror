From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH/RFC v3] add a commit.verbose config variable
Date: Fri, 11 Mar 2016 03:08:51 +0530
Message-ID: <CAFZEwPP5_rBKH_=0pv_3PszLYtnznXeGJg1+yjwbiH0m_BqdZQ@mail.gmail.com>
References: <0102015361e5441b-bbc448b5-7307-451d-a951-f016f7ae4b1d-000000@eu-west-1.amazonses.com>
	<xmqq7fhadnkv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:39:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae8IK-0002YZ-Dy
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbcCJVix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:38:53 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33208 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180AbcCJViw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:38:52 -0500
Received: by mail-yw0-f172.google.com with SMTP id d65so79018787ywb.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 13:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=DnrQkfcG7dgzab0wd3agxUztcWhTXSzEPO80RiEord0=;
        b=q1ZLHjiPLECGOSElTCv2b6PMhgo9D5v08YJ0ejxxyXQpSDB7u3l/FBLqSifFfhviYv
         9dmmDTOJamfzqSrFgBRe/6szWC10iKOS699txLPeOLe8ucArXeBci89y80VvzB8e4PlY
         2CXMmYMiCpPyEy11zP4UU6zKZ8Arx8+/+cGfd2aeoQHWd8z5mcF4JeMBh4hDHasUwGPD
         41vULKbttFwI6Ep45eIs/dM5n+OODtWWl+qhE7LKlPMeYzS2mdvzlLN1ToNNAMzlA2QE
         8m9yRXcr4HFwi/13cDRpaW9EVAvvO0ON41S5iwaSWForkD1yd6dYGPBriqwOLkyMmsjI
         5UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DnrQkfcG7dgzab0wd3agxUztcWhTXSzEPO80RiEord0=;
        b=QU3cdPMkGt0yrQqQkjWT/TWACiA13hvvNSuBp1oKbi3zyyFgGO+KWmDR2t3Y/tUPqp
         oeCwPGDuhTD01S55k3ou8OzDWahBCnbh7hDVe9YpU0Ephqlm/AQGejDBTFVfIfEj7MzC
         CnDZ3el3qi6Z7Vk5onPdDADUv+RkRKziQD3p/epNp+yloHVABrtSFBWWzSfAo0ixbQ2E
         sJZAYhqSZylhkimJLXKilMHCw0N5+TZlX54GZPetgwaPUUhVCK7r76eV/hVZxZK+VAgt
         EfO+QRs4+9KfoY7sVqPQoc9KslycAPYPW6HDnyX+vNPxX99aMCkIG82bgXj3Ct720mGM
         41yA==
X-Gm-Message-State: AD7BkJKLqNdIRzplbpQX+pn4h4TdoJabc16qYOXAn6cs3EnqJ5L5zhtIUi4q0CwbNuAeZA5iK9xD/4hFxe5sUw==
X-Received: by 10.13.252.67 with SMTP id m64mr3538453ywf.67.1457645931565;
 Thu, 10 Mar 2016 13:38:51 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Thu, 10 Mar 2016 13:38:51 -0800 (PST)
In-Reply-To: <xmqq7fhadnkv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288645>

On Fri, Mar 11, 2016 at 3:04 AM, Junio C Hamano <gitster@pobox.com>
wrote:
> But doesn't this belong to git_commit_config(), not
> git_STATUS_config()?  Should "commit.verbose" make output from "git
> status" verbose?

True. It should belong to git_commit_config(). My bad. But
surprisingly this code works. I have no idea why. I will update the
Patch and I have also finished writing test so I will include that
also.
