From: Mark Rada <markrada26@gmail.com>
Subject: [RFC] Gitweb: include minified version of js and css files in the repo
Date: Fri, 12 Mar 2010 23:31:25 -0500
Message-ID: <1B527F20-CF6C-451B-9C6E-1BE74992354D@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJ0i-0006t7-TM
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824Ab0CMEbb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 23:31:31 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33585 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758816Ab0CMEba convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 23:31:30 -0500
Received: by gyg8 with SMTP id 8so679310gyg.19
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=jk0KebYvk+U8VAMYH3fJ2VzK6CHsMFjNa2+sC9C3ZPM=;
        b=hBvEHhB1COASMS1kaAhtSb4Cr6Jg6k0GLlfj3A4JfXd2bWk2RH44VlxQZjRUokxhdM
         SNz6E8rwTFSxBM49T+V8/bz/pca+vvoY/qRjtbmSEd2ejk/MDAKE4RKQxrr12SuyECZR
         uR6Fn+8NpfWz5giJWxdaT+ceuXl06fPQ4toXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=j7sKRc1lXLpwGjht4KKTcHVNbRbd+NjqkSvYO2hPNCQ4VQ/r4b80D9+B1tuGJsuZSs
         1rnudr7cE60teUnTJboNXIw4DfV2snXsDu2NrEwpo87NVhmvYbUUqgA2KfmscIMhSt+L
         u9Qzcw6nSZJvw/ZPJ+uxZxD3Tkzxc9VbxFs7o=
Received: by 10.91.137.19 with SMTP id p19mr1374064agn.57.1268454688978;
        Fri, 12 Mar 2010 20:31:28 -0800 (PST)
Received: from bas1-toronto01-1177657629.dsl.bell.ca (bas1-toronto01-1177657629.dsl.bell.ca [70.49.161.29])
        by mx.google.com with ESMTPS id 21sm1425220iwn.15.2010.03.12.20.31.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:31:28 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142073>

Hi git devs,

I was catching up on the changes to gitweb changes in the
last little while and I noticed an option to pass gitweb.js
through a minifier during the make execution, which I thought
was pretty cool.=20

However, I was wondering if there were any reasons why the
minified version of the javascript code was not distributed
in the git repository? It seems like you are leaving that
effort to be duplicated a lot by people who compile git
themselves.

=97
Mark Rada
markrada26@gmail.com
