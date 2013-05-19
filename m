From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 20:47:32 +0530
Message-ID: <CALkWK0kuj00uUW5C5zKyaCBM72HBzxAk9G2UT1P3bKx9Lc8tkg@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
 <1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com>
 <CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com> <CALkWK0mA9zWjco1fYRu4O2QmMRJE7vd2Z3CyJj=a1VxCyymMvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 17:18:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue5NJ-0006O3-4e
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 17:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab3ESPSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 11:18:13 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:52818 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab3ESPSM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 11:18:12 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so12256654iec.35
        for <git@vger.kernel.org>; Sun, 19 May 2013 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Rf5+EBmq3j+IF1nTw9xgDnF3ACKpxQEY4lYYnlRWixo=;
        b=Pu4qwCM4oNy58lGROLIkZwwxZjXSX6d/ni53BH3WweNRIoUb7eVzjwRmtxPPlvAk+k
         7QP7BeIiAWt2SqtrtHh3cRBHV6WRN9O4qkuBY8l6UcWDyNz+665GTNX8bdQYJzF3FCQ8
         HUHg8UWe8BoZMKZYqM4FWIkjhcGdmgbtrQITkvBRVw5j9+QmjALr5zh+BHXaMLTtvUNT
         eKs+Oj445GT5AQ2rxP6FMcofusAGeq18UmFLBiowwJGg4hA4VAdKBedf/japFPJ8MzCO
         eOaTVjNTFeocbZoPA26lNnI9tKeObiQhQRcRoXkRb87+jWm7p6utwSpIV5Hbvtz9cxYs
         raNg==
X-Received: by 10.50.73.65 with SMTP id j1mr3216895igv.49.1368976692414; Sun,
 19 May 2013 08:18:12 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 08:17:32 -0700 (PDT)
In-Reply-To: <CALkWK0mA9zWjco1fYRu4O2QmMRJE7vd2Z3CyJj=a1VxCyymMvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224892>

Ramkumar Ramachandra wrote:
> There's a non-optional space before the "<email>" in your regex, which
> is what I was pointing out.

Er, scratch that.  It's the space after the "Whatevered-by:"
