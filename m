From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [WIP PATCH 3/7] Import dump_node to dump what changed and cleanup 
	whitespace
Date: Wed, 23 Jun 2010 19:05:22 +0200
Message-ID: <AANLkTilNcL5sKVPo9nGytHoSh8qPwsi1ldKr2hu6oHpU@mail.gmail.com>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com> 
	<1277310140-16891-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 19:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORTOk-0000ON-O1
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 19:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab0FWRF6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 13:05:58 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38986 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab0FWRF5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 13:05:57 -0400
Received: by gwaa18 with SMTP id a18so111677gwa.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rYXDuhXetPX+xkGwkXyjga7NxMWz6mgaeM/zs5SDo0A=;
        b=N/wkHuJB1rHQihYb5vryPNKDBXOnGdb7qKwYF6oCPJfqFIpq9aPTqLL02UQTqiq3pq
         9/36Ato4joQ/BRgWW2sLKg8WBRB9Y/fqVZl34JkTeWKATZFovzkF5dNeKlJ+MrEZbkVM
         3bGndwNPKwnH0gKo4s3uwWC3hoV0WHKUdgXkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=n7+ETaxmwAj8+98xdMJH01m17L6Y6isqod6lUZm2DlLhGh7gxONvkhzy+o5t7022dO
         vyWeLPSgycGtASFMyWP26meGYDl1zJx76meZfxuawb9VmD4yC6W3bmi+B8mnurfq0i9e
         QEE9+UZLEJwT+K50bOSQg1m9WBW6FkKIkDOC8=
Received: by 10.229.247.211 with SMTP id md19mr4389312qcb.146.1277312742288; 
	Wed, 23 Jun 2010 10:05:42 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Wed, 23 Jun 2010 10:05:22 -0700 (PDT)
In-Reply-To: <1277310140-16891-4-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149519>

Hi,

Ramkumar Ramachandra wrote:
> +Licensed to the Apache Software Foundation (ASF) under one or more
> +contributor license agreements. =C2=A0See the NOTICE file distribute=
d with
> +this work for additional information regarding copyright ownership.
> +The ASF licenses this file to you under the Apache License, Version
> +2.0 (the "License"); you may not use this file except in compliance
> +with the License. =C2=A0You may obtain a copy of the License at

Daniel pointed out that my code isn't licensed to the ASF before it's
merged back into Subversion; the dump.c I've taken directly from the
Subversion trunk is though. I'll find out the exact semantics and
correct this.

-- Ram
