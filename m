From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] Fix the shallow deepen bug with no-done
Date: Fri, 7 Feb 2014 11:20:31 -0800
Message-ID: <20140207192031.GY30398@google.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <xmqq4n4cyr61.fsf@gitster.dls.corp.google.com>
 <CACsJy8AdOdVCma8FYeDM0kTd=Bgo-atpXmxFvmK4rzH6jOZEzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 20:20:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBqye-000795-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 20:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbaBGTUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 14:20:36 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:39212 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaBGTUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 14:20:35 -0500
Received: by mail-pd0-f173.google.com with SMTP id y10so3522832pdj.4
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 11:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qKtkC39DWyyXKYHWv1aSZ/SBtrxzRULOflGarRrP0U8=;
        b=psSWeYzZqlBpoK9lgmjFr5tZmi27gixRircr9jp1cG0+SULtSd1PJ4WNU8E8szBl2A
         ZQ2yC1GjrCyFNyMuanY9lvX0iX6ChZG9r7WzrM+RO0A7ytaQC77GP7kDmmLc3tWweST3
         7kUskvUalKdmKCpTWS7w2X2GMDYHLa87sBoktwzfd3tXhQ6+YfVUWf0lC8ijaXpoDiv8
         Om8wxfFiKXqLe4IOySDb6hZKPc2CIi35LhEHwbWkUg+Wb55OQ4tXnQp/mt4HgiAHJlw3
         2hRqkQvlJv3/cVlM393T7KpenUMUzb2NVDHXUt3wKcWmWvvJ2G3JODvA599OETTdkqb7
         fEMQ==
X-Received: by 10.66.156.137 with SMTP id we9mr9977534pab.30.1391800834918;
        Fri, 07 Feb 2014 11:20:34 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bz4sm16236689pbb.12.2014.02.07.11.20.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 11:20:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8AdOdVCma8FYeDM0kTd=Bgo-atpXmxFvmK4rzH6jOZEzQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241791>

Duy Nguyen wrote:

> Don't take it the wrong way. I was just summarizing the last round. It
> surprised me though that this went under my radar. Perhaps a bug
> tracker is not a bad idea after all (if Jeff went missing, this bug
> could fall under the crack)

I'm happy to plug
- http://bugs.debian.org/cgi-bin/pkgreport.cgi?src=git;include=tags:upstream
- http://packages.qa.debian.org/common/index.html (email subscription link:
  source package = git; under "Advanced" it's possible to subscribe to
  bug-tracking system emails and skip e.g. the automated build stuff)
- https://www.debian.org/Bugs/Reporting (bug reporting interface -
  unfortunately the important part is buried under "Sending the bug
  report via e-mail")
again. :)
