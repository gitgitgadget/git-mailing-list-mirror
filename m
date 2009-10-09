From: bill lam <cbill.lam@gmail.com>
Subject: combine git repo historically
Date: Fri, 9 Oct 2009 09:22:54 +0800
Message-ID: <20091009012254.GA3980@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 03:27:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw4GC-0006h8-7A
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 03:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158AbZJIBXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 21:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756103AbZJIBXh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 21:23:37 -0400
Received: from mail-qy0-f172.google.com ([209.85.221.172]:43950 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbZJIBXg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 21:23:36 -0400
Received: by qyk2 with SMTP id 2so6152632qyk.21
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=NOd0Z70ZNDyzD9zBnHMnjQKEjWbczfhXVVrGPsm5Qvg=;
        b=ntLp9a2V7TARIgwV3lm4hjckC0Kd4NsRjMHvYpTX1wrow++Ap9AG2LUnquXlURTgGh
         GoRSLUMlvFxOxZTNJxz4SBD22id7hk+O7ZgwXeGGalH3oI/Yv39xTnGJYROcQa4f0Vka
         AthF0c8BValdEYkPsBH5rVuT2fD6lR8K1lVao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=sNbWAqm/w+IBJJqkohpCINzegmWLFLdovO6jYK26mB18vJ2mOXX1L20cc+vR2081sz
         f3iBWdMUI5LwsSGCp+NBEWqo+Fz7ZAlxMXbuAPRQ1em+R0F5uqfIyujq3fn1ggcaKxBx
         uY8ZmgOoj/mkhW3a3/VDQPB3TvIeIqKTf6g/M=
Received: by 10.224.113.153 with SMTP id a25mr1963184qaq.154.1255051380481;
        Thu, 08 Oct 2009 18:23:00 -0700 (PDT)
Received: from localhost (n219077027017.netvigator.com [219.77.27.17])
        by mx.google.com with ESMTPS id 8sm31044qwj.34.2009.10.08.18.22.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 18:22:59 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129727>

I have two git repos, no branches.

repo 1.
  emptyrootcommit -- A ... M 

repo 2.
  emptyrootcommit -- N ... Z

N was evolved from M but the time gap is large, how can I combine them
into one repo

emptyrootcommit -- A ... M -- N ... Z

so that snapshots N .. Z will not be changed.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
