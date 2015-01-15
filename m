From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] init-db: remove unused #includes
Date: Thu, 15 Jan 2015 16:13:00 +0600
Message-ID: <CANCZXo5UY80327pvjzYkJXroH_WZdW36LhSANK0O7GGVQLF=AA@mail.gmail.com>
References: <1421258367-8483-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq61c99o25.fsf@gitster.dls.corp.google.com>
	<xmqqwq4p86i6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 11:13:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBhQh-0005vP-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 11:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbbAOKNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 05:13:05 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:52672 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbAOKNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 05:13:01 -0500
Received: by mail-oi0-f47.google.com with SMTP id z81so11673251oif.6
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 02:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=44zIcnchXQHMATrMFKldf6vbHuFe+ktUpd2fDPNHBjE=;
        b=xnbaiq/krDyNAzFwOT4BGrCtRg0uAAv9UqJ8Vjv473jphe+nuW0sYtdHC5g8Rbvc8P
         u13xqamMXLJkYMUjejwZzd3W4jcwiTVs7p8p/erAa0tbEm5OxxDG1YaBWgyvqKDexn9/
         M4qHSNbr7BtBAkybNTPmX2kPmDNQz5QXg2lbaU6utQkO9ws3e9X6U94P6/QMeahedryy
         VRzqSVxGLcwKjtzFGVrA363w4LleDTCo6v/uVGO+MR0W0tikKrtmFMRC6dhZudbcTdb8
         OesZhfdYJndxDlDA+Uea/DhkQ2y1u5PItgNRJ0hPsJ0TllyuReEqkDkv/8KWI65xEByx
         aD9w==
X-Received: by 10.202.220.85 with SMTP id t82mr4996117oig.43.1421316780071;
 Thu, 15 Jan 2015 02:13:00 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Thu, 15 Jan 2015 02:13:00 -0800 (PST)
In-Reply-To: <xmqqwq4p86i6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262471>

Hello Junio,

yes right, missed system_path usage. But it's strange, code still
compiles successfully without exec_cmd.h.
