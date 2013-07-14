From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib.sh - cygwin does not have usable FIFOs
Date: Sat, 13 Jul 2013 17:59:12 -0700
Message-ID: <20130714005912.GB21033@google.com>
References: <1372975470-13573-1-git-send-email-mlevedahl@gmail.com>
 <20130707005558.GI30132@google.com>
 <51D93164.8030202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 14 02:59:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyAem-0008Gq-7Z
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 02:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab3GNA7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jul 2013 20:59:16 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35383 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3GNA7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 20:59:16 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so9732808pdj.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 17:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MKNuRWq0f0HTEv++RrcQK+RXt8O9Gq7eg6H2Z7RmshQ=;
        b=EGbfwZjisYgQgl42nN7Qm10oKm5pZptmcznpEZ1Ws3Xae7D61JSf7Cg/J0eTzgXWDo
         A6ldIZo72m3eZ0OPzzZoU6n1yx6RH38DukBbLq068tM1OrbRekuZIVeP+O/ZNvewHZlW
         qvDZCJgV0ZV7sgp7XYa7p+IMktSFqYMMEGY7NeEvyC4E+aSnZ2Ro0pL2P3SGQAOgAp/M
         U1ak7Harhe4Au7ozFlSjyu5M7sje9dJXeEJfYnQS25nCxoQ8aTkRtEYp6QeMTuKKXDoD
         CeyV/dq9auxmezg/H+jiSQ7cnFB1xHV010ddu4K2XCfs7wUM5eyz5HivIQhGhuJNtJP2
         JRMg==
X-Received: by 10.68.52.10 with SMTP id p10mr48321047pbo.92.1373763555680;
        Sat, 13 Jul 2013 17:59:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id zn4sm56054903pac.21.2013.07.13.17.59.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 13 Jul 2013 17:59:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51D93164.8030202@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230297>

Torsten B=F6gershausen wrote:

> Disabling PIPE under cygwin seems to be the right thing to do,
> or do I miss something ?

If fifos don't work on Cygwin, disabling that test prerequisite
is defintely the right thing to do.  I was taking the opportunity to
find out whether and how git could be tweaked to avoid needing fifos
when setting pipes up in scripts.

Jonathan
