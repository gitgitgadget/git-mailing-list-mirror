From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Problem with Integrated Vim Editor on Win 10
Date: Thu, 31 Mar 2016 08:49:39 +0200
Message-ID: <1459406979.21328.14.camel@kaarsemaker.net>
References: <CAAErz9i1=EOemq2qNijRwgY6MNmPJRhV+mFfeD1FZa5uPwvCJw@mail.gmail.com>
	 <loom.20160331T083046-590@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Peter Olsson <peter@olssononline.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 08:50:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alWRE-0004GC-OS
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 08:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066AbcCaGu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 02:50:26 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33566 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbcCaGto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 02:49:44 -0400
Received: by mail-wm0-f45.google.com with SMTP id r72so127420320wmg.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xVx4gH+SMD7vh1yxxMulJOPy2W/vAzviB9grUSxivAE=;
        b=bcBwoUWDddCiHtRRBCtHrNevpMcE9Qh3U70s3HrcPNEwwnWiB1mv9yYFqwP+YHKmF6
         0yDL8RSVS9AprNdIaWgOp3LdwpclXlWDHvbgGyl9+Opc0tAM9xg/NBwpJTByz/YJzVL2
         eUTHufTv/XzGiHyeKNYOrZL84hnJzn5BspRiXklHTT9uv+uuufJ7PNd4HER6kaI4sLIQ
         lQSvK1S0NVlt14PRlNQ6w3CaK6xr8Lmq2nwj3hEAAPECcEKNwxtFCHnKWoODF1x7jj31
         4IJFL77qb0zFBiOYfAgrnbkNZADbWiifbgfBeW+TFv1nMuhwsvHjbFxo2o9SnnZpQr2l
         J/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVx4gH+SMD7vh1yxxMulJOPy2W/vAzviB9grUSxivAE=;
        b=mFdqiL/jlX2Np0AJH7DJ7vJD7ENov6em2pLfwB86OwprKxjZbAlNsWvuDkvAV+6fnV
         knDrkmOB1gup7wBY1QccQ3qM63gm2c1KbCtHjaapBTuoFskag54YJbG7CdviNemLhkD3
         xwcMmUYlW+0eZDGGH8ijCHDN3ocRguw8dxaQQpnOCzP1RygsbwTai6xxK+DXBdoM/NEp
         mlsY5frzD2MXwEjRXqDQgXUdQa7XlHQAAM+WdYP6qjwj/hQi6iK6eU3TuncUR+rKXIWM
         CPYR1PGCBgkTIvJnqf8UGsqmAeOXIta43+eY1BhWqNg+QObkIOTNdc0SeD7eatUb+qU4
         u7vg==
X-Gm-Message-State: AD7BkJKN/K8XxBctjPuakJu0HE5PmGTe7E98s4xvr+NQzdrIl7vVpoIRvMmfY3QoJ5cjaA==
X-Received: by 10.194.238.34 with SMTP id vh2mr15095965wjc.157.1459406983375;
        Wed, 30 Mar 2016 23:49:43 -0700 (PDT)
Received: from seahawk.local (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id yn10sm5394055wjc.45.2016.03.30.23.49.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2016 23:49:42 -0700 (PDT)
In-Reply-To: <loom.20160331T083046-590@post.gmane.org>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290374>

On do, 2016-03-31 at 06:33 +0000, Peter Olsson wrote:
> I'm not sure where we should report this?

While the git-for-windows maintainer does read this list, git-for
-windows specific issues should be reported in its issue tracker on
GitHub.

It looks like this issue has been reported already:
https://github.com/git-for-windows/git/issues/711

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
