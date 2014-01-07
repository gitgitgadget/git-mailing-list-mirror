From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 0/2] better document side effects when [re]moving a submodule
Date: Tue, 07 Jan 2014 22:30:08 +0100
Message-ID: <52CC71E0.7010603@web.de>
References: <CAByyCQCakKyUqJQDdFrTMf2CUJihRhqSUVCwT21VDN1EOerVWw@mail.gmail.com>	<52A602A2.6060909@web.de> <52CB023C.2050001@web.de> <xmqq8uushgz3.fsf@gitster.dls.corp.google.com> <52CC4021.60209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: George Papanikolaou <g3orge.app@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:30:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0eE4-0003yc-Dq
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbaAGVaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:30:13 -0500
Received: from mout.web.de ([212.227.15.14]:51011 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaAGVaL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:30:11 -0500
Received: from [192.168.178.41] ([84.132.139.6]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LeLWP-1Vbinc0rev-00q9r2 for <git@vger.kernel.org>;
 Tue, 07 Jan 2014 22:30:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52CC4021.60209@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:cQPitbNUeb6wyrWWEqFHv4C72kr9Jw8fuwQkKcQz0C2eXnHW7Pe
 O0PPmZk2KfBtjQ2NgxLcGZGTVj53D9YmgNdqAaUWYKUT2CrozxcVfWfcD5cYxHkLWQWtM2O
 XUyFXv+eiZ+oe2uGY6V9CWxT+WpkOMtChHAbOfmmrljtWEcDYSwwCUcGtQCEY0u1Z2DRvmF
 WfcDNBbvFPcoNzhIp943g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240159>

Am 07.01.2014 18:57, schrieb Jens Lehmann:
> Am 06.01.2014 23:40, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>> Does this new paragraph make it clearer?
>>
>> Don't we have bugs section that we can use to list the known
>> limitations like this?
> 
> Right, will change accordingly in v2.

Changes from v1:

- Document side effects under the BUGS section

- Add similar documentation for "git rm"


Jens Lehmann (2):
  mv: better document side effects when moving a submodule
  rm: better document side effects when removing a submodule

 Documentation/git-mv.txt | 12 ++++++++++++
 Documentation/git-rm.txt |  9 +++++++++
 t/t3600-rm.sh            | 16 ++++++++++++++++
 t/t7001-mv.sh            | 21 +++++++++++++++++++++
 4 files changed, 58 insertions(+)

-- 
1.8.5.2.231.gfc86eb1
