From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Confusing error message from "git pull" when upstream repo no 
	longer exists
Date: Tue, 29 Jun 2010 12:55:29 +0200
Message-ID: <AANLkTilbqmedF9Wh3dG3n9HYtuZuq4PzTwOp6T8NCjQ8@mail.gmail.com>
References: <op.ve14xqlq0i1pst@centurion>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 12:55:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTYTf-0004iX-9l
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 12:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab0F2Kzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 06:55:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56167 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab0F2Kzb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 06:55:31 -0400
Received: by fxm14 with SMTP id 14so1247197fxm.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 03:55:29 -0700 (PDT)
Received: by 10.102.237.8 with SMTP id k8mr2042776muh.41.1277808929553; Tue, 
	29 Jun 2010 03:55:29 -0700 (PDT)
Received: by 10.103.138.16 with HTTP; Tue, 29 Jun 2010 03:55:29 -0700 (PDT)
In-Reply-To: <op.ve14xqlq0i1pst@centurion>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149898>

On Tue, Jun 29, 2010 at 12:33 PM, Per Cederqvist <cederp@opera.com> wro=
te:
> When running "git pull", I get this error message:
>
> =A0 =A0fatal: /usr/local/libexec/git-core/git-pull cannot be used wit=
hout a
> working tree.

This error message is shown when you try to pull in a bare repository
(without a working tree). It seems you don't have a working tree, but
you have a repository, so you can still fetch. (the working tree check
is done before the fetch).

HTH,
Santi
