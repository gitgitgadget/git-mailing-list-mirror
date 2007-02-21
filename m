From: Xavier Maillard <zedek@gnu.org>
Subject: Re: git-blame.el won't run
Date: Wed, 21 Feb 2007 13:08:26 +0100
Message-ID: <13478.1172059706@localhost>
References: <13283.1171492535@localhost> <87mz393mlo.fsf@morpheus.local> <24475.1171920735@localhost> <87abz92rp9.fsf@morpheus.local> <4157.1171992534@localhost> <87fy9020ne.fsf@morpheus.local>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 13:11:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJqJm-0004u2-QW
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 13:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbXBUML2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 07:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXBUML1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 07:11:27 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:32815 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbXBUML1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 07:11:27 -0500
Received: from localhost.localdomain (cha51-2-82-244-211-40.fbx.proxad.net [82.244.211.40])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A36C281142
	for <git@vger.kernel.org>; Wed, 21 Feb 2007 13:11:25 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1LC8QZl013479
	for <git@vger.kernel.org>; Wed, 21 Feb 2007 13:08:46 +0100
In-reply-to: <87fy9020ne.fsf@morpheus.local> 
Comments: In-reply-to =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
   message dated "Tue, 20 Feb 2007 18:34:45 +0100."
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40295>

Hi,

This is the backtrace after C-g (after a few minutes):


Debugger entered--Lisp error: (quit)
  process-send-region(#<process git-blame> 1 28910)
  (let ((display-buf ...) (blame-buf ...) (args ...)) (if startline (setq args ...)) (setq args (append args ...)) (setq git-blame-proc (apply ... "git-blame" blame-buf "git" "blame" args)) (with-current-buffer blame-buf (erase-buffer) (make-local-variable ...) (make-local-variable ...) (setq git-blame-file display-buf) (setq git-blame-current nil)) (set-process-filter git-blame-proc (quote git-blame-filter)) (set-process-sentinel git-blame-proc (quote git-blame-sentinel)) (process-send-region git-blame-proc (point-min) (point-max)) (process-send-eof git-blame-proc))
  (if git-blame-proc (message "Already running git blame") (let (... ... ...) (if startline ...) (setq args ...) (setq git-blame-proc ...) (with-current-buffer blame-buf ... ... ... ... ...) (set-process-filter git-blame-proc ...) (set-process-sentinel git-blame-proc ...) (process-send-region git-blame-proc ... ...) (process-send-eof git-blame-proc)))
  git-blame-run()
  (progn (let (...) (if ... ... ...)) (setq git-blame-cache (make-hash-table :test ...)) (git-blame-run))
  (if git-blame-mode (progn (let ... ...) (setq git-blame-cache ...) (git-blame-run)) (cancel-timer git-blame-idle-timer))
  git-blame-mode(nil)
  call-interactively(git-blame-mode)
  execute-extended-command(nil)
  call-interactively(execute-extended-command)

Regards,

Xavier
