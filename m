From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The 9th production of the msysGit Herald
Date: Wed, 13 May 2009 00:57:31 -0700 (PDT)
Message-ID: <m3my9hl9jv.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0905130225330.27348@pacific.mpi-cbg.de>
Reply-To: jnareb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed May 13 09:57:45 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-1516.google.com ([209.85.146.160])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49LU-0003GY-99
	for gcvm-msysgit@m.gmane.org; Wed, 13 May 2009 09:57:44 +0200
Received: by wa-out-1516.google.com with SMTP id k39so290754waf.53
        for <gcvm-msysgit@m.gmane.org>; Wed, 13 May 2009 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:received
         :received:x-authentication-warning:to:cc:subject:references:from
         :date:in-reply-to:message-id:lines:user-agent:mime-version
         :content-type:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=Y7z89zAahyyFmaUFW/xGBaf6JJK1GlKIX4Ff7qZi5wo=;
        b=jhw0LO0zaA6NYcxk/8doA0hIuibAe3W8owJ+EVjbcbd02WHzt5J8d4sTKRfFuoy8Z6
         VzRP+tpLJ974+atqmQ70mhN47RMAMk+HcKpKnkJF4GrMWkLNiH0dPZAmk/LAG5DCLWWI
         6/vtX64N97UlgGzDl/wVBOXUgXfsMcuVq8zFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:x-authentication-warning:to:cc
         :subject:references:from:date:in-reply-to:message-id:lines
         :user-agent:mime-version:content-type:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=WiUSNozWJferqzfxws3B0xOTJDsPCmv7Q/jxq7wyNRN7FBEUUZyeOzSQLCqyvARcuy
         TtpmdfS5uB4IgI38nMuzo74skV+ssJmQP43wskxCZ6vuRFcdN7FM5GCXz4hAUxijZ9D1
         VeslMVFIc/1HjZY6xAenm+zkTHGJLFPJ0k0cU=
Received: by 10.114.255.12 with SMTP id c12mr119660wai.14.1242201453593;
        Wed, 13 May 2009 00:57:33 -0700 (PDT)
Received: by 10.106.129.7 with SMTP id b7gr5213prd.0;
	Wed, 13 May 2009 00:57:33 -0700 (PDT)
X-Sender: jnareb@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.151.144.4 with SMTP id w4mr722130ybn.25.1242201452988; Wed, 13 May 2009 00:57:32 -0700 (PDT)
Received: from yx-out-1718.google.com ([172.21.8.36]) by gmr-mx.google.com with ESMTP id 22si59835yxr.2.2009.05.13.00.57.31; Wed, 13 May 2009 00:57:31 -0700 (PDT)
Received-SPF: neutral (google.com: 172.21.8.36 is neither permitted nor denied by domain of jnareb@gmail.com) client-ip=172.21.8.36;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 172.21.8.36 is neither permitted nor denied by domain of jnareb@gmail.com) smtp.mail=jnareb@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by yx-out-1718.google.com with SMTP id 36so266311yxh.42 for <msysgit@googlegroups.com>; Wed, 13 May 2009 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:received:received :x-authentication-warning:to:cc:subject:references:from:date :in-reply-to:message-id:lines:user-agent:mime-version:content-type; bh=+rIsGfXxf2pX/JnXSp9sZAA3jPFkdDWsKRC6hkhXwRg=; b=p2tqBinCtceZ4XairKquLH6Qw1ZucCJ/WE9wi56RHWAb2wsWjQka3lgxEsa0OfEXDb ODnkL65mYAJGRPtszCQkT+zlp/xOEZg56mBLkTObNIg58tcaBRbKhxpFyZcNlqaWY6/k QTOkQ9tT0GXhpYxEuPuPAat/Ra8BHbvRoxIno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=x-authentication-warning:to:cc:subject:references:from:date :in-reply-to:message-id:lines:user-agent:mime-version:content-type; b=j9oN3q0KJyYyXly4uIApEpF59+2BUidU/1E+fiz4WLSqZmo3RE95IhqT3d/8H7lZnV 04TE+MoREa39EAzD018BeUO/lEELJBCQXQMcmSIzzcKYKQ5M9QAuwygUwKNqUFlwMoyX 0cI0gAcXJHFulATeMxz7BuPTeTjm9PQRYqVnU=
Received: by 10.100.138.8 with SMTP id l8mr505934and.32.1242201451821; Wed, 13 May 2009 00:57:31 -0700 (PDT)
Received: from localhost.localdomain (abwb156.neoplus.adsl.tpnet.pl [83.8.225.156]) by mx.google.com with ESMTPS id 20sm1296578agd.38.2009.05.13.00.57.30 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 13 May 2009 00:57:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4D7vQQJ008288; Wed, 13 May 2009 09:57:26 +0200
Received: (from jnareb@localhost) by localhost.localdomain (8.13.4/8.13.4/Submit) id n4D7vP8X008285; Wed, 13 May 2009 09:57:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0905130225330.27348@pacific.mpi-cbg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118998>


Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

[...]
> We started recently to ship Portable Git packages, i.e. archives that 
> only need to be unpacked (as opposed to be installed). 

Is it Portable Git as in PortableApps.com ?

[...]
> TortoiseGit vs GitCheetah
> =========================

What about Git Extensions (http://code.google.com/p/gitextensions/)
project?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
