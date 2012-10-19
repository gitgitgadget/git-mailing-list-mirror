From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] gitk: fix --full-diff handling
Date: Fri, 19 Oct 2012 15:22:36 +0200
Message-ID: <CAMP44s1F9eKpSiTQLTjXz4R0NewaMaw3554O=ynvGFXsKYEaaA@mail.gmail.com>
References: <1350644213-4882-1-git-send-email-felipe.contreras@gmail.com>
	<508151A0.3050505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:22:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPCXI-0003xK-Hu
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 15:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399Ab2JSNWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 09:22:37 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37816 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab2JSNWh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 09:22:37 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so378436oag.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JsO9TEhRzbKTO9I5NeiN3QYYTS95OvBtjuDfoyHlMtE=;
        b=i0ePrE3KBbI7PE7Ary9L2pHsryvdY9V8L/0XuwDgHMMmS6MXklb3iSXj0Ye5v5+4Od
         8QrPoP1JL3Jz38rGFHtLyv/lYCyyqvXq6BCDgDEwj5y1PcOAsIgNiC9+6DbRMfW01RRl
         aCBDahyLblYZxBrrLAUisj8O5DJ/JydrA9cPmZ1aspu0vr3qEjauVvR2eg/Pf7MG4a9p
         NxhzQgsGvtxmeKl5Sl2ma+nUW+NwD7naoaPgIWZ7EJl47eMSomArHMAcIuYv6LrQREJh
         1FO/K7Ip5xh/sMB9dDAnK5O8+jOIATJCO+lWbHjtQFVyMYH2pcsujHezwGUOZaP71uLk
         icJw==
Received: by 10.182.245.20 with SMTP id xk20mr388082obc.89.1350652956663; Fri,
 19 Oct 2012 06:22:36 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Fri, 19 Oct 2012 06:22:36 -0700 (PDT)
In-Reply-To: <508151A0.3050505@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208047>

On Fri, Oct 19, 2012 at 3:12 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 10/19/2012 12:56, schrieb Felipe Contreras:
>> I find usel to do 'git log --full-duff -- file' to find out all the commits
>> that touched the file, and show the full diff (not just the one of the file).
>>
>> Unfortunately gitk doesn't honour this option; the diff is limited in the UI.
>
> There is Edit->Preferences->General->Limit diff to listed paths. Doesn't
> it do what you want if you switch it off?

Hmm, I guess so, but it's not triggered from the command line. Maybe
the --full-diff option should enable that flag.

-- 
Felipe Contreras
