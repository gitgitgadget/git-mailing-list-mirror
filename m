From: =?ISO-8859-2?Q?Bojan_Petrovi=E6?= <bojan85@gmail.com>
Subject: Mistake in git-reset documentation
Date: Sat, 27 Oct 2012 13:21:18 +0200
Message-ID: <CABPGWqr7=Rq4qS7yP09t2vMBUJ98NFTSmHUUgMzUQ5=WVrjfqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 13:21:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS4SL-00029s-Ow
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 13:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951Ab2J0LVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 07:21:20 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59479 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab2J0LVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 07:21:20 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1408903eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 04:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KgBkfUgSPCTBNkCtYAE0UaEcktfetFJeJqB4cnjsW3A=;
        b=vpvX0BkoOSw3euoBkvt+OMW3+eYvBAeE5j/tPzyMRodXD+OdVhUxhWBq14jep+E20E
         IGHR5G++1cKFSV2FReAMW8WrnwruYo3XGi9AR0nYXTWg01YPxN2r776OtL/EL1ElfXoW
         FpkoItCrS7x0AYMgq4z12bFOwzBH0Ui5WgEsCYbgtK/TuKe1y/v3XxJDNU9ZjD54oUEA
         ZfT/yEVYMI0+5b2gojfL8c7ZIUpjE7edz5cW6vnNVTdUDHTUt6qb2EVd/mgeaRGo0XNH
         7QMDCaryMf+H2Bg8eBh4uqJxjTSBoE5PqCc6eTtJEUX61iPsf1076nw+5XI79y6FFsgC
         yMWQ==
Received: by 10.14.223.4 with SMTP id u4mr41463069eep.19.1351336878882; Sat,
 27 Oct 2012 04:21:18 -0700 (PDT)
Received: by 10.223.144.68 with HTTP; Sat, 27 Oct 2012 04:21:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208505>

None of the three forms of git-reset accept: "git reset" which is the
equivalent of "git reset -mixed".

Square brackets should be used instead of parentheses for "--soft |
--mixed | --hard | --merge | --keep".

Bojan
