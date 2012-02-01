From: Oleg Kostyuk <cub.uanic@gmail.com>
Subject: [BUG] gitk and "Ignore space change" option
Date: Wed, 1 Feb 2012 04:42:48 +0200
Message-ID: <CAAPa60iq=TKZQnktL+1QBLD_wtWm0-JKbNbDk31fhSyN6T3TfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 03:43:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsQAE-00034w-C3
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 03:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab2BACnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 21:43:09 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62520 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab2BACnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 21:43:08 -0500
Received: by dadp15 with SMTP id p15so481326dad.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 18:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=g+zBRr9YQExLMI5HbgPSmWnvT1wlqEatht+woDxt2jA=;
        b=eqmBgG0eeSc7K2Zercnx6xTp8IFDHtRzFwwlhIlldUJRlqlX/ABkYqerM8yE5w3NGe
         JP7x/Q91zGdamI6V1pNARFnTx+nvrkNZ309McTehEgCJH/h02f9zdtLhdIjXVZ/NkECI
         f0J5GpNHda4KuI1DxU54UnwGjSLrDuCfhfaxs=
Received: by 10.68.83.105 with SMTP id p9mr55417302pby.92.1328064188132; Tue,
 31 Jan 2012 18:43:08 -0800 (PST)
Received: by 10.68.12.132 with HTTP; Tue, 31 Jan 2012 18:42:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189495>

Debian/testing, git version 1.7.8.3

There is no possibility to:
1) save value of "Ignore space change" option into config file (~/.gitk)
2) pass some option in cmd line (like --ignore-space-change or -w)

So, there is no other control to "Ignore space change", except via
configuration dialog. This is very inconvenient, and I think this
should be considered as bug.

As solution, any of (1) or (2) could be implemented, but if both -
then this will be fantastic :)

Thanks!


PS: could be useful -
http://stackoverflow.com/questions/8221877/gitk-setting-ignore-space-change-option-to-be-true-by-default

-- 
Sincerely yours,
Oleg Kostyuk (CUB-UANIC)
