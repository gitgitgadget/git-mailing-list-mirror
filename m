From: "Mike Coleman" <tutufan@gmail.com>
Subject: suggested feature: someone mails me a blob, git please tell me what it is
Date: Fri, 16 Feb 2007 10:23:40 -0600
Message-ID: <3c6c07c20702160823j316c52f4pe4cf5ca8a882e194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 17:24:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI5si-0001rE-9k
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 17:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945980AbXBPQXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 11:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945983AbXBPQXl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 11:23:41 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:5961 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945980AbXBPQXk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 11:23:40 -0500
Received: by nz-out-0506.google.com with SMTP id s1so929062nze
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 08:23:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rsZqCjRSvejkN0X0SHvg8EXsH3jiG1rXg/vKDegjzw8xzv3sux7Kyqsi9SKI9LGLGDPhHH12I0Zw0Ns6KLnh0eSBjb565wPMst7BwKcwlwylOBFb6PA0dyNt8Oyl5stH94d3aAE5BTRekHYOYkkunBj7sQgtU+eOedI7CaE80FM=
Received: by 10.64.131.4 with SMTP id e4mr5212446qbd.1171643020179;
        Fri, 16 Feb 2007 08:23:40 -0800 (PST)
Received: by 10.49.92.17 with HTTP; Fri, 16 Feb 2007 08:23:40 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39925>

Here's a suggestion for a git feature, if git doesn't already have it.
 Since git generally doesn't use RCS-style keyword cookies (like
"$Id$"), it'd be nice to have some other way to identify an installed
file.  Perhaps you'd want to know exactly what rev a user is running,
for example.

It seems like it should be fairly easy, given a blob (the file), for
git to describe what it knows about it.  For example, it could provide
a list of commits that it's a part of, etc.  It'd be *really* nice if
only the output of the sha1sum command on the blob were needed.  (I
can't recall exactly how git's blob SHA1's are computed--maybe this
isn't feasible.)

Mike
