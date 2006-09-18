From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Mon, 18 Sep 2006 07:48:29 +0200
Organization: At home
Message-ID: <eelbtu$56s$2@sea.gmane.org>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net> <7vu035u4c3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 18 07:48:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPBz6-0006lG-Jg
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 07:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965397AbWIRFr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 18 Sep 2006 01:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965411AbWIRFr6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 01:47:58 -0400
Received: from main.gmane.org ([80.91.229.2]:52191 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965397AbWIRFr5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 01:47:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPByu-0006jJ-Jt
	for git@vger.kernel.org; Mon, 18 Sep 2006 07:47:48 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Sep 2006 07:47:48 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Sep 2006 07:47:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27225>

Junio C Hamano wrote:

> =A0 =A0 We really need some test suites for gitweb.

Could we use the git.git repository itself for testing gitweb?
At least checking if there are any errors or warnings?

The problem with test suite is that you really need _two_ tests;
first if there are any errors or warnings, then if page looks like
it should. The first can be done by simply running gitweb with
at least the following enviromental variables set:
  export GATEWAY_INTERFACE=3D"CGI/1.1"
  export HTTP_ACCEPT=3D"*/*"
  export REQUEST_METHOD=3D"GET"
  export QUERY_STRING=3D""$1""
The second should be done by looking at gitweb output.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
