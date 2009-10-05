From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH] Make the MSVC projects use PDB/IDB files named after
 the project
Date: Mon, 05 Oct 2009 12:08:21 +0200
Message-ID: <4AC9C595.7040209@gmail.com>
References: <hacfq0$g9k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 12:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MukVx-000861-7W
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 12:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbZJEKJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 06:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbZJEKJH
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 06:09:07 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:54797 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477AbZJEKJG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 06:09:06 -0400
Received: by ewy7 with SMTP id 7so3315979ewy.17
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 03:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lxkxtUB5Nfm5N08HYoP2mw7rJJbwGk6+ZrvgeJwwesA=;
        b=XCUs5MqHJVGvKnoweLZ5XRXGeP3iNr+EmkwWPO80qskpKmsm4VtBi2UB9YaN8sido3
         NZ0P3yPQ57InidW+1j4fBYkawJ+Rue4d20Gth4dwjDIY9EVlgOiBqKFHNzwA049QjCm3
         Qiy9E3n1B6kP+LpdGrj3NLDznTlcVo8mzJzb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=LNw27mzgOTu8CPrqJ8ua8EhlPguqL71klf8pU7VPPjrv9O72CpYiBU7oIbyK29xktd
         S07XKWwZkna3uJ2V/AeoftzdT0EKcAIYfIJAwpbUV9sCysd1gCnuCSWb3zOYSRSHOg2Q
         b7JUvkCCUurX4CXrEXJG9/M3MbDbaU+Z81vGw=
Received: by 10.210.95.26 with SMTP id s26mr3143322ebb.7.1254737308355;
        Mon, 05 Oct 2009 03:08:28 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm1971304eyg.27.2009.10.05.03.08.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Oct 2009 03:08:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <hacfq0$g9k$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129547>

Sebastian Schuberth said the following on 05.10.2009 11:54:
> Instead of having all PDB files for all projects named "vc90.pdb", name them
> after the respective project to make the relation more clear (and to avoid name
> clashes when copying files around).
> 
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

Acked-by: Marius Storm-Olsen <mstormo@gmail.com>

--
.marius
