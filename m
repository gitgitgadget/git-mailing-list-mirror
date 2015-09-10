From: Jacob Keller <jacob.keller@gmail.com>
Subject: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 09:28:52 -0700
Message-ID: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:29:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za4ir-0002UZ-4h
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbIJQ3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:29:13 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34359 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbbIJQ3M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:29:12 -0400
Received: by iofb144 with SMTP id b144so67523981iof.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=brE+QhBLDcYZ7M0i45G85ZP0cjhglsolU9Ceky8fb+w=;
        b=VqOVex20RjX7ad+2PqgvGw+jWZkym6aAuo3bG42M4TBV9AvDdJbayoyViI2REKQ8N5
         LgjRaMSFLCcFhyQTmIKF/ek590RyLM5hMnbkCyCI9Hui2OrYUbGU9jlb+bzE2QFW9crq
         LCxDRP/jdyXXuu2bKNOuyU4umdDwTP+avmzddwORkXe2ITJzSxvY2HefJWpCy5hTtGIi
         Jc7lk1G/cbT8i0z5hLt4dop0fDQL5qGXRFjKxzVLrZQT/LJ9AwI5Q0otGBABOBzGuu5W
         rtCzFS5zHBK1BVyXi6VKqzRjHQUAGOnw7GpmldVL9d5zRrJXkyecNLKEFtaAziNv9XX1
         7c+A==
X-Received: by 10.107.166.201 with SMTP id p192mr28911618ioe.0.1441902551656;
 Thu, 10 Sep 2015 09:29:11 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 10 Sep 2015 09:28:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277600>

Hey,

does anyone know of any tricks for storing a cover letter for a patch
series inside of git somehow? I'd guess the only obvious way currently
is to store it at the top of the series as an empty commit.. but this
doesn't get emailed *as* the cover letter...

Is there some other way? Would others be interested in such a feature?

I get very annoyed when I've written a nice long patch cover letter in
vim before an email and then realize I should fix something else up,
or accidentally cancel it because I didn't use the write "To:" address
or something..

I really think it should be possible to store something somehow as a
blob that could be looked up later. Even if this was a slightly more
manual process that would be helpful to store the message inside git
itself.

In addition, this would help re-rolls since it would mean if I go back
to a topic and re-roll it I can just update the message. If it were
properly stored in my local history that would also mean I could see
revisions on it.

Any thoughts on how to do this?

Regards,
Jake
