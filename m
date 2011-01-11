From: Jeenu V <jeenuv@gmail.com>
Subject: git notes and core.editor config
Date: Tue, 11 Jan 2011 15:41:40 +0530
Message-ID: <AANLkTi=0BrBV+DLF_QfDi0mMVdz5tCLFsDMBKvw52nzz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 11 11:12:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcbDA-0008Cf-AF
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 11:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab1AKKMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 05:12:17 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51290 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab1AKKML (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 05:12:11 -0500
Received: by wyb28 with SMTP id 28so20292919wyb.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 02:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=je+0HGpgiWyp7nge5rxYatlxe8i3i6cvucuR6OyZW0w=;
        b=sobxVA4iHLO9WtMASIxogTk+aeCiHya7hBJKODkkmPdhGUhUW6c6VbOYP1PONUE899
         M4qDR004Ju54K9P8l1DpTPrC7hade7jZ5NQ4+fJO5pY++e87Os6xqqcBRpDjoqvehv0Z
         SkgWxtTrgFuYhL+Up+2uMu2d46KE9H3VGFDlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=QxVb01goaFCUd4nH3+QUOZJETqGAB74/IBV0YfMdIE0XNR3jUISzfxWaoU3acSsBae
         ZMxXlpZsyPSllbGpMup3NYl5gO4WlkxeeRLFw9YnEf6zZmxVNzc6jQvmXlnDtMQ86QK4
         59yxzSrvatQZX4NjbLZbh3wibxgtLo+NCfnvc=
Received: by 10.216.51.137 with SMTP id b9mr876895wec.54.1294740730277; Tue,
 11 Jan 2011 02:12:10 -0800 (PST)
Received: by 10.216.254.166 with HTTP; Tue, 11 Jan 2011 02:11:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164924>

My core.editor value in $HOME/.gitconfig is set to

  [core]
      editor = vi "+set tw=72 spell"

so that I've text width of 72 with spell check turned on. I haven't
found problems with any git commands that invoke editor, but notes.
'git notes' seems to invoke the vi for me with 3 separate arguments
instead of just one: "+set, tw=72, and spell". In other words, I don't
think it honors shell quoting for editor config variable.

Could this be a bug?

-- 
Jeenu
