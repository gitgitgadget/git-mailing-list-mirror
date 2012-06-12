From: Piotr Pientka <p.pientka@gmail.com>
Subject: submodule update --init --recursive doesn`t work git 1.7.10
Date: Tue, 12 Jun 2012 10:07:02 +0200
Message-ID: <CAMgq-fJN=-XnHOZyAUbQ4uiQ61Ryzn-4d69QBtUJeXAxNvSBiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 10:07:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeM8A-0003SX-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 10:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab2FLIHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 04:07:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59229 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab2FLIHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 04:07:03 -0400
Received: by obbtb18 with SMTP id tb18so7973332obb.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/cd2wL26pSFRV2kNv7l4JSd9dC8slyQEsrfjYvqLiug=;
        b=UpcobVGpLC1wUwWVesymhuYBXvAgjwApAePW0lNuvH7U8ngntm2ZtuGTj6DoHV7Cgy
         WMGXWgW08aC75txQ8AKpdATokJ27bRsbPZf9fxFr9LIuRcY9Gd3r+eHICPslWLbV437k
         dFMaPaXcpkBiYhwlKRwO228W/f0ofPxE+gRSZrLeclAR5UpY7eCcjLxFhmP/aA06S2K2
         6ILA5iEAM3k40aUk6agbzx+NmxqqJD3i1ppOryh5G7BQzSqXIbgSkbK+FzP36icAx/Nn
         YVpodbM8xWEgtMM9aXh/2sVdmfdJBYXCjyW5JyLC5oCoFgB4l7nzFsQw7gwcWhANsbBg
         q+8g==
Received: by 10.182.51.100 with SMTP id j4mr19624827obo.78.1339488422410; Tue,
 12 Jun 2012 01:07:02 -0700 (PDT)
Received: by 10.76.79.230 with HTTP; Tue, 12 Jun 2012 01:07:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199770>

When I have nested submodules, after Add new nested submodule and make
"submodule update --init --recursive", I have failed while cloning
nested modules.
It looks like is a problem with path to .git

But when I add new submodule and make "submodule update --init" on
each nested module, it works , but I must do it manually

It only happends on git 1.7.10. On git 1.7.4 it works fine.
