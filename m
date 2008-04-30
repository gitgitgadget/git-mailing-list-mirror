From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Importing a strange svn repo layout w/ git-svn
Date: Wed, 30 Apr 2008 07:50:31 +0200
Message-ID: <481808A7.6080908@gnu.org>
References: <alpine.DEB.1.00.0804300011390.29172@rose.makesad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 07:51:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr5Dw-0007se-C3
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 07:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758999AbYD3Fuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 01:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759010AbYD3Fug
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 01:50:36 -0400
Received: from hu-out-0506.google.com ([72.14.214.231]:60066 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758972AbYD3Fud (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 01:50:33 -0400
Received: by hu-out-0506.google.com with SMTP id 19so363105hue.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 22:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=BYo31R+mJ/pDymjl8pmcIJlo63jTAcoPW/ch5Wug+eU=;
        b=nXq2yjTzI8tGNM1A+xw9QuybUEuM3owzBXa/tWOPEWUHDuNWsE6/YSqyBUUa1VJR4ZLXeH/piUw/hB+GCOrLbBsE8qGgc9rnY13cFClLO7768V88mlG2rk4kmOJqodGsfj5O8lCdPExpSYDuIlzklnPcTUxc+se8mi3ROUlis1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=AwKRVWDx1rc6YPJ5/IcTUb+x+s1tU5/+zPt13Xeqi8ZYR+ZOHfQ8z3MlWmhNEQZbiLHVA2E0tfHlENJLr084LGAzpc7eBEboFuzqepUwVGCYGfXD29KisP8/n6dX7KJwEUGQhyRcbHZ97qBfwWZNZaweelsf7w6f26WdPX2jy4Q=
Received: by 10.86.26.11 with SMTP id 11mr331394fgz.23.1209534630225;
        Tue, 29 Apr 2008 22:50:30 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id 3sm259134fge.3.2008.04.29.22.50.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 22:50:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <alpine.DEB.1.00.0804300011390.29172@rose.makesad.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80795>


> Is there a way to get git-svn to handle this situation?  Perhaps git-svn 
> has a "suffix $DIR to the repository URL" option that I missed.  If not, 
> is it conceivable it could?

See the CONFIGURATION section of git-svn(1).

Paolo
