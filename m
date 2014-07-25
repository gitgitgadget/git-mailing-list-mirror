From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [RFC PATCH 2/3] home_config_path: allow NULL xdg parameter
Date: Fri, 25 Jul 2014 19:27:48 +0530
Message-ID: <53D2625C.9070702@gmail.com>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr> <1406295891-7316-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 15:58:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAg0U-0008AI-DO
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 15:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760114AbaGYN5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 09:57:54 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48146 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbaGYN5x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 09:57:53 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so6131891pad.21
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=z6t+39xiJHCw9s85jKqoCMuufi5fRVPkTvsVDzCFHZs=;
        b=d/M6dQP4hOt11WQtvqanZR7JyNZiT7/tyULOgPVifCF+AnL43+F3OERyeh5UvkUCjt
         SNyJAIj/UpiPkjn3Moi8mob9aCCyimAXpY5G7ECa/1pbZHStiOPBshmhXDpJRIjpMrob
         Usy0obk+Pv7WY1AXc+pPMgvR9bMSwvOf4xtdgSRWDAALglEArr2/nvfDo8BzpHc3mOnu
         tPYVBxbfnacxjxbRmyXdxysz5/ZYZTR56hFZe7v9Gwk6oJGDKL6OL7Q5IsyYkvFuDX+5
         o/jBqhGobQE6sWvBDC74sdFGn6WizSL4RUvs2Q+VCDO4Z5MuZm0TKCw4nvJJdqmwySU9
         uSsQ==
X-Received: by 10.68.164.226 with SMTP id yt2mr18766152pbb.89.1406296672926;
        Fri, 25 Jul 2014 06:57:52 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.246.45])
        by mx.google.com with ESMTPSA id c5sm11803363pdh.93.2014.07.25.06.57.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 06:57:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1406295891-7316-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254221>

On 7/25/2014 7:14 PM, Matthieu Moy wrote:
> This allows a caller to requst the global config file without requesting
nit s/requst/request/
