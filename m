From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2013, #07; Mon, 23)
Date: Mon, 23 Sep 2013 14:54:56 -0700
Message-ID: <20130923215456.GG9464@google.com>
References: <20130923211047.GD9464@google.com>
 <5240B184.8060101@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 23:55:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOE5z-0007MV-G8
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 23:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab3IWVzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 17:55:01 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:47463 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab3IWVzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 17:55:00 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so3727994pdj.26
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4A34S6eoMV7jS+r5DwSNgqScO/2XnHu1qoE78z+lipk=;
        b=yV/nwrnEafKmNYOAKIDGQ1aZ2ZRnfGw09WqvvzlgB8/c4HQbTqbOKy/6QdGVmuf3wx
         B4rRJLf/1lMJzUEFLT/miOkEpuZSU0QXxBPE67NyiQpgYjZe+kjKu8gDSDz6+WXIKvCK
         WhgumFCV5b2Vk8/m9a/wpvrmIOCB1/jpCGHhODi+QNeyz8fzPNQhWqrDlUx8e2mqCN/L
         JOuIbR8aUyMcz1gccNiiZoiRBajGsWanmDC3CVOy+M5xEp1nXa9P9pS7NXChz1ZWGhkP
         rC2BcwQcUNL/jw+ou91SEv2uARgfyxCudJaduiCoBjw0yv8g7aLnp/zlJwdvnS3+jQU5
         7/SQ==
X-Received: by 10.68.252.106 with SMTP id zr10mr15545838pbc.63.1379973299809;
        Mon, 23 Sep 2013 14:54:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kd1sm40516251pab.20.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 14:54:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5240B184.8060101@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235250>

Stefan Beller wrote:

> 	git fetch https://repo.or.cz/r/git/jrn.git
> doesn't work, as it yields:
> fatal: unable to access 'https://repo.or.cz/r/git/jrn.git/': server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none

Ah, figured it out.  http://repo.or.cz/h/rootcert.html explains.

Later this week I'll start pushing to multiple hosts, including github
which has a certificate signed by DigiCert.

Thanks again,
Jonathan
