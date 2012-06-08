From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: show refs points to a commit
Date: Fri, 8 Jun 2012 21:37:57 +0200
Message-ID: <CAN0XMO+G6K0FZgu35OuuqGEp322vLpakXHXBTPpUQmoex68srA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 21:38:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd50Y-0008N5-9L
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 21:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab2FHTiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 15:38:00 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58787 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757832Ab2FHTh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 15:37:59 -0400
Received: by wgbdr13 with SMTP id dr13so1192720wgb.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/XwpHQgTFNMEK8hfOmQPyx7j1fwF7bmNqca6jpl5i3Q=;
        b=U3Sc8TjNV8upaS9GhtIF3UOhZhwbYMgJ8LIYn5ZxAGrbKXnRaFFGYOTFTeR+2tPCns
         uVmN3aABM6rOiYBwbwz4hW+UONFEog0JcAAQpqfz3culoRRX3ab6lnOWA6TkbGwLQby6
         yzP4Z9ZSp2svG27yi3yF2FFY2pQorHDvk4em4MPtnEtZFg6OyP+0sMhQNrCjKCaQ/UJD
         LdcziaGtoLtl3WfKDgrkyTAWU3xkhHSighfvNKsbjuqNaEOVc9pTEH+JJI+QsLOGXuaY
         HrbydAu3LYS8drMWSDeHRXjnvYTANadyYOKTZk5ag+oQhg08OEP/0Vy9L3t7tR3rzYZ9
         hv1w==
Received: by 10.216.145.97 with SMTP id o75mr1977049wej.7.1339184277561; Fri,
 08 Jun 2012 12:37:57 -0700 (PDT)
Received: by 10.194.0.132 with HTTP; Fri, 8 Jun 2012 12:37:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199520>

After playing around with submodules, I haven't
found a builtin way to show refs pointing to a
specified commit without using UNIX pipes.

Especially when you working with submodules, it
would be very helpful to know which refs
points to this commit in order to switch from
"detached HEAD" to the branch you can (maybe)
work with.

Or did I miss something?

Thanks

Ralf
