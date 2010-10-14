From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: Removing dos end of line
Date: Thu, 14 Oct 2010 12:51:10 +0200
Message-ID: <AANLkTimCXs_eORsZKPx69sLk4jgHMY419qOH1DEMPQRF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 12:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6LPT-0006nJ-RH
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 12:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab0JNKvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 06:51:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38623 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab0JNKvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 06:51:35 -0400
Received: by mail-iw0-f174.google.com with SMTP id 41so670363iwn.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=QrMCJtKsrJc9UNaj1E4MtVx0m1RiIgkWUZWS5e++tQI=;
        b=L4z9pDzsoxp+vIlvk6q1GjyACOtyUoxZNm95qnRmU079BNjrDDMVr0FPZpek7RKCh+
         ROEZ9QzhATCVFkA/ykjcAw594P5o3RnC15+ANR5O+vI1ugCdCUCeV7ENflKxsD6lpxtO
         A2Q4uwHAbcxRM4HhLNxaZ9rIOqv5+WG2G757Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=UU2GK0YjoAWFWS4Pu4G5uQKIJJjcE2gRETRzj5bqrktYrJj1dFE/+Pinu5vHaTpVxj
         U74rNc3aGzv04ekbt2Ji3YLZ0B9adWFyN6fYufKYq52vyRWoLY9a7b/AGabnFtF2lzFh
         Podymk+22cNy9hD/fTTdiqh7u3pWlFcbXlNYw=
Received: by 10.231.14.5 with SMTP id e5mr7993002iba.175.1287053494681; Thu,
 14 Oct 2010 03:51:34 -0700 (PDT)
Received: by 10.231.34.72 with HTTP; Thu, 14 Oct 2010 03:51:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159045>

Hi,

  I am trying to rewrite a git history and remove dos end of line. I used:

git filter-branch --tree-filter dos2unix -- --all

However it still report:

error: You have local changes to 'bla.c'; cannot switch branches.

Here is my setting:

$ cat ~/.gitconfig
...
[core]
	autocrlf = input


Should I be doing something else to remove dos file from history ?

Thanks,
-- 
Mathieu
