Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E971FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 14:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbcFWOnS (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 10:43:18 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38470 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbcFWOnR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 10:43:17 -0400
Received: by mail-wm0-f52.google.com with SMTP id r201so53354223wme.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 07:43:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spinlet-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=jDFnlHGE33c4zApDqWUCC96+oS0TkMsJJ9gYyYsRWbY=;
        b=NH9O6czOwXb0sIIS3i0i8W4bhBJsWQtnYBd/LlVOf+1Njz49Oaq6HRsQknXDH4e0cp
         1h+SUZh5MakYFP6/uqDv0aBhi2XWmjg1XGdEOONOY1r3GONjVTKJrGOqOwXYLvdZ6h6L
         WSF1sThlqo+McyvmYlkndtlO9AIz4wTIzwRWnNqKDsgAP8ud4C19bG2pxbIuKjw5E7rj
         TKS64KHAza/BbAlcmrWmDmwjWos2GLL0TzF4uJz/SWxovzspFN4QS6NW0MRP9id31Y01
         2YsGkdfESWKXnQ4mx4oFoGKgOlXZnmkOlWozg6/01K23b6K1Zgg1JpmLC+3vhh+nt6Bq
         snTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=jDFnlHGE33c4zApDqWUCC96+oS0TkMsJJ9gYyYsRWbY=;
        b=WPDBKvxGQ/pgzx7+2+Ce9k3/cr9Tdxb/kQcIvLKmh3VaN7NvzHhg9tMY/z1VBfZgyJ
         ajrxkRu7I9OO5/VWwWcYE874YZ1MV4ZglraDe5EaNvOUrI1/GDPVAgICpSVeZPZWTKXK
         xP9ge3IPDE+HLWKNhHerLPFd2oJQ4Q+QNoniLySQem/coDOvyNwR/uC9UIS+fIKYVfbY
         xlcOP7+Tha3pPxvWxRkIEoLOtauZK3+MswCs817Oblk+XWfeEnn7rYHO3D++9kJV+FEy
         Mudob/BetM74m6v05dAhVhddtHOK3gaMi2fns1+Y6wtAIawsVq2G1AYlFN4oeAVN44SU
         onfA==
X-Gm-Message-State: ALyK8tLkkSZ7y9bQ6g46VqwNl5GpWAIJSIW9EJ84ZuIt8tizqbkY0sff2sUXutUxqcSs3FsE
X-Received: by 10.194.87.42 with SMTP id u10mr32421308wjz.152.1466692995855;
        Thu, 23 Jun 2016 07:43:15 -0700 (PDT)
Received: from [10.205.72.242] ([197.211.53.28])
        by smtp.gmail.com with ESMTPSA id d192sm4225830wmd.14.2016.06.23.07.43.14
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 07:43:15 -0700 (PDT)
From:	john@spinlet.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (1.0)
Subject: GIT admin access 
Message-Id: <E9A37D7D-AA14-48CD-83CA-819766313D78@spinlet.com>
Date:	Thu, 23 Jun 2016 15:43:09 +0100
To:	git@vger.kernel.org
X-Mailer: iPhone Mail (13F69)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi, 

We need some help accessing our private Git as admin. The admin is currently unavailable and we need to provide access to a new Git user.

Thanks & best regards,

John AJAH