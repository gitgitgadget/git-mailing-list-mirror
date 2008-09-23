From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Tue, 23 Sep 2008 13:57:12 +0200
Message-ID: <adf1fd3d0809230457u200f4331n849b302eabe4f960@mail.gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 13:58:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki6X9-0007A4-Kr
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 13:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbYIWL5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 07:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYIWL5Q
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 07:57:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:43022 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYIWL5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 07:57:14 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1734805muf.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 04:57:12 -0700 (PDT)
Received: by 10.103.198.15 with SMTP id a15mr3601605muq.60.1222171032690;
        Tue, 23 Sep 2008 04:57:12 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Tue, 23 Sep 2008 04:57:12 -0700 (PDT)
In-Reply-To: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96553>

Hi,

  Just some comments.

  When you exclude the .gitignore file all the ignored files are
reported as "Untracked files". I.e, as in:

$git clone $git_url
$ cd git
$ make
$ git checkout --reset-path=Documentation/
$ git status

  When you have local changes it says that it cannot switch branches

$ git checkout --reset-path=Documentation/
error: You have local changes to 'Makefile'; cannot switch branches.

$ git checkout -h
...
    --reset-path <prefixes>
                          reset to new sparse checkout
    --add-path <prefixes>
                          widen checkout area
    --remove-path <prefixes>
                          narrow checkout area

s/prefixes/sparse patterns/

Best regards,

Santi
