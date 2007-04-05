From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-gui blame dividing by zero
Date: Thu, 5 Apr 2007 09:33:11 +0100
Message-ID: <200704050933.14154.andyparkins@gmail.com>
References: <200704041621.51390.andyparkins@gmail.com> <20070404161101.GF4628@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 10:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZNPn-0004jw-QW
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 10:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946100AbXDEIdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 04:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946101AbXDEIdZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 04:33:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:11891 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946100AbXDEIdX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 04:33:23 -0400
Received: by ug-out-1314.google.com with SMTP id 44so920641uga
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 01:33:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LIjYqX2FvWBE2rKh6zGaOZJDrP02/0kn70bfktPVpC33NEgFZZqO5oQNoqV+Dde7sDTpyr6P5i/IEfgdOiBwydSC9DnQzJzxHcqTPoHmdQCfAJu/HNGobNJZ4/DKtwS2VXcbf1P8rpCsagLswkxic4TiwF2jDvumSIKzumebYUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=apFu37uw/Qn4Op0dGUePDxPwhieB/jwg1Av2t3ukKWgUXInkJOLzWsdS7wn/PAt7WVV34fdOz4MutOS+zHa16NK1qkaq8LVPFs4rJEFIImKxTBbGGoZP+45wlGZZNHfj9lkMtkVLgIcH8giuJTjxp9+Mvs5XoVhCS0nY/LW4FLQ=
Received: by 10.67.31.17 with SMTP id i17mr799052ugj.1175761997335;
        Thu, 05 Apr 2007 01:33:17 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z33sm3102870ikz.2007.04.05.01.33.16;
        Thu, 05 Apr 2007 01:33:16 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <20070404161101.GF4628@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43808>

On Wednesday 2007 April 04 17:11, Shawn O. Pearce wrote:

> I just pushed a new patch to my git-gui.git repository, its now in
> both the maint and master branches.  Please give that a try.  ;-)

Okay - it's an improvement - no more divide by zero error.  However, I don't 
get any output.  Just an empty window with HEAD:somefile.cc in it.

The following both give lots of output:

 $ git blame HEAD -- somefile.cc 
 $ git blame --incremental HEAD -- somefile.cc

So; I think you've fixed a nasty bug, but that bug was only presenting because 
something else is messed up.  I'll poke around and see what I can discover 
(however, I don't understand tk so what I discover might be that I don't 
understand tk :-)).



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
