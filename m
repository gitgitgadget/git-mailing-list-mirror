From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] notes: attach help text to subcommands
Date: Fri, 8 Jun 2012 10:36:07 -0500
Message-ID: <20120608153607.GC10380@burratino>
References: <7vd359eu4s.fsf@alter.siamese.dyndns.org>
 <1339169317-12134-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 17:36:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd1Ec-0005xV-0u
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 17:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761276Ab2FHPgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 11:36:18 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46993 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757781Ab2FHPgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 11:36:17 -0400
Received: by gglu4 with SMTP id u4so1354431ggl.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AYfJzQYKI6gHJrOo5m6Ed+d77G/fhIYr5/iyX8pmN4E=;
        b=kjn2bFleMsplGF3KAp+2J0QfVpWyeU0TFPZyqiMBzGzmvkx1uGMw+GyF4sk4Z44w3Z
         VTXENDKipvoNc4vwxoS9ih88UcO2VlRukFHM7s+e3+jwHdkq2UQz7ImRv+OEt1wfTWAM
         t3/o6Mgh+GFbze3XaZ5oMNozRBEc91TpVuxrM/CK5RJskcdUxQXihhwdykFDhZ2y/B4X
         VcY52K8+EbL2R1GyGZAHuFGQYNETbWqIVjWQ0+INKeSmn0vHnLxvvBq5QiPuCoqdhGRO
         Y9j22IVRFZLlCdIM+aypM8cLawZgVznFSUNh25VlbA8OQhQldG/grTAyFc5UBieSaVtD
         1Wew==
Received: by 10.236.136.8 with SMTP id v8mr7770140yhi.101.1339169777233;
        Fri, 08 Jun 2012 08:36:17 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id v22sm22419089yhl.2.2012.06.08.08.36.10
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 08:36:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339169317-12134-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199506>

Ramkumar Ramachandra wrote:

>  Thanks.  I wish we could do something aout USAGE_OPTS_WIDTH and
>  USAGE_GAP; I stole them from parse-options.

Expose them in parse-options.h?  Or put this functionality in a
parseopt-related file?

Copy+paste must die. :)
