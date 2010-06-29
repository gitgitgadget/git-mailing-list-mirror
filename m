From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: recovering orphaned commit
Date: Tue, 29 Jun 2010 17:24:24 +0200
Message-ID: <20100629152424.GE4724@debian>
References: <AANLkTiks6yPfdTACQwZlqv8PPPEg3RYGMx1Q1PjT0nRu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 17:29:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTckr-0005eJ-Eu
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 17:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab0F2P3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 11:29:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59552 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab0F2P3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 11:29:38 -0400
Received: by wyb38 with SMTP id 38so2814602wyb.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ksje5gVrQNiwIhg/9ldtnJsYVdFw6DzmOc7UExqHEuw=;
        b=lN65ntkwtc66fpM4I6+7QhA2U87a6OHOWd86gHf/obOiNpMHE6GT4uJzszUG6JmaYj
         gMTMzQuGN75NSJIkGJIS1tiGzDDDXhf8kNVPbNxkmiQQ3hclHoaTzKo5aOB7DsHBVPTe
         1jxolILwpxzAnDXFm7vROSswlRYbfr+21SybA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=MgL+/Vg7fj5Q/vbECaz1zRm9N9eSzA/T9zSlvfwvzfL2ad9dhBywjx3rpwbA9NVl9l
         tQiYHDT5YXw2PpZUaiOHwtnVZAHlFVqBpDqFVHH6LUcJ2O0TBT56wK+q4tnz1sKftZMU
         XZDvsoUeGlj60HhLwF4Nm4eE3G3oljsb7/eDU=
Received: by 10.227.142.200 with SMTP id r8mr5377239wbu.72.1277824964218;
        Tue, 29 Jun 2010 08:22:44 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id s47sm1665301wec.13.2010.06.29.08.22.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 08:22:43 -0700 (PDT)
Mail-Followup-To: Mahesh Vaidya <forvaidya@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTiks6yPfdTACQwZlqv8PPPEg3RYGMx1Q1PjT0nRu@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149908>

Hi Mahesh,

Mahesh Vaidya writes:
>  I have a situation like this; 2 commits.
> 
> Example -
> 
>  2899684ed173063354b7fe4f5ec7216e7d953e2c	 <-- HEAD  ( say C1)
>  1ef67de1a0d6e97470a8c827d2989317600532ff                    ( say C2)
> 
> To see file at C2 ; I have done git reset --hard C2; I could see the file.
> Now want go to C1 ; Ho do I Determine C1  using git command ?

Use git-reflog (1) perhaps?

-- Ram
