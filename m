From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Fixing translation errors in gits error messages
Date: Sun, 3 May 2015 20:01:29 +0100
Message-ID: <CAKB+oNve6xyTe3QZyf1AkV6A1aDKr9mgTXuM8V9eEKVrjwmQnA@mail.gmail.com>
References: <CAKB+oNsa5c3zwx03pm7P_FDO3Xdxgr+rBOncAAmAjQL4LLJOdg@mail.gmail.com>
	<xmqqh9rtv8yz.fsf@gitster.dls.corp.google.com>
	<CAKB+oNs2XLZSgJODcJ3_U-sgfFt4XjoO0AYW3HLKCdZRt7waeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 21:01:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yoz91-0003eD-5P
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 21:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbbECTBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 15:01:35 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34235 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbECTBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 15:01:30 -0400
Received: by qcyk17 with SMTP id k17so63463655qcy.1
        for <git@vger.kernel.org>; Sun, 03 May 2015 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=OWVi0T4QSZ2ec9qA6ZOsrv/K0qT8UcZur8+d2V+lZBU=;
        b=SlQZJDc92hstjnxbIW1FPz4TqDYD7DvensRvcDMlkfiETSw6spIZ2Iy8eRMMTbcWKC
         TX/YzNGGLFHK6hR0RP90DLvP6LXAHh0h0yYLxP3fcOKOXwumxOqGZSKKzUTaSfznbvN2
         +WTASXDcCqcKB+kOG2p8fbeu3KZg4mYPcbHfVOctvG65dy3ifMXYoCwu8mU9SYNeew3x
         zj39k3DVehqYEe49UTEBSAk+snjM6RQNhdI/D93DVQa+jbV7Ft7mvjPw1+OkoPCLubrK
         5jiC0iTU7J0KkPt6XdaitMnYidLXO3dGBPJz/LrKpAfIiSGAqRNaEb2E9+wgqjL67XAx
         wP/A==
X-Received: by 10.55.40.132 with SMTP id o4mr38598966qko.61.1430679689571;
 Sun, 03 May 2015 12:01:29 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Sun, 3 May 2015 12:01:29 -0700 (PDT)
In-Reply-To: <CAKB+oNs2XLZSgJODcJ3_U-sgfFt4XjoO0AYW3HLKCdZRt7waeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268282>

Just for further clarifications, just tell me if i am correct. This is
and example of that i am fixing right?
void NORETURN die_resolve_conflict(const char *me)

 {
  error_resolve_conflict(me);
- die("Exiting because of an unresolved conflict.");
+ die(_("Exiting because of an unresolved conflict."));
 }

Just tell me if i am on the right track.

Regards
Alangi Derick Ndimnain
