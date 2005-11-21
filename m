From: llandre <r&d2@dave-tech.it>
Subject: cvsimport and RTAI repository
Date: Mon, 21 Nov 2005 16:19:01 +0100
Message-ID: <4381E565.4020108@dave-tech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 21 16:20:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeDQg-0001l0-Kf
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 16:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVKUPR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 10:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVKUPR6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 10:17:58 -0500
Received: from host46-203.pool8538.interbusiness.it ([85.38.203.46]:18436 "HELO
	dave-tech.it") by vger.kernel.org with SMTP id S932295AbVKUPR5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 10:17:57 -0500
Received: (qmail 16323 invoked by uid 0); 21 Nov 2005 16:21:50 -0000
Received: from unknown (HELO ?192.168.0.6?) (192.168.2.253)
  by 192.168.2.1 with SMTP; 21 Nov 2005 16:21:50 -0000
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12447>

Hi all,

I'm trying to cvsimport vulcano module of rtai CVS repository at 
cvs.gna.org. Unfortunately it does not work: git-cvsimport hangs after 
printing the messages below. git version is 0.99.9.GIT. Anybody can help me?

Thanks a lot in advance.



[llandre@linuxserver rtai]$ git-cvsimport -v -d 
:pserver:anonymous@cvs.gna.org:/cvs/rtai -C vulcano vulcano
cvs_direct initialized to CVSROOT /cvs/rtai
cvs rlog: Logging vulcano
cvs [rlog aborted]: received abort signal
cvs: lock.c:178: lock_name: Assertion `(__extension__ 
(__builtin_constant_p (strlen (current_parsed_root->directory)) && 
((__builtin_constant_p (repository) && strlen (repository) < ((size_t) 
(strlen (current_parsed_root->directory)))) || (__builtin_constant_p 
(current_parsed_root->directory) && strlen 
(current_parsed_root->directory) < ((size_t) (strlen 
(current_parsed_root->directory))))) ? __extension__ ({ size_t __s1_len, 
__s2_len; (__builtin_constant_p (repository) && __builtin_constant_p 
(current_parsed_root->directory) && (__s1_len = strlen (repository), 
__s2_len = strlen (current_parsed_root->directory), (!((size_t)(const 
void *)((repository) + 1) - (size_t)(const void *)(repository) == 1) || 
__s1_len >= 4) && (!((size_t)(const void 
*)((current_parsed_root->directory) + 1) - (size_t)(const void 
*)(current_parsed_root->directory) == 1) || __s2_len >= 4)) ? memcmp 
((__const char *) (repository), (__const char *) 
(current_parsed_root->directory), (__s1_len < __s2_len ? __s1_len : 
__s2_len) + 1) : (__builtin_constant_p (repository) && ((size_t)(const 
void *)((repository) + 1) - (size_t)(const void *)(repository) == 1) && 
(__s1_len = strlen (repository), __s1_len < 4) ? (__builtin_constant_p 
(current_parsed_root->directory) && ((size_t)(const void 
*)((current_parsed_root->directory) + 1) - (size_t)(const void 
*)(current_parsed_root->directory) == 1) ? (__extension__ ({ register 
int __result = (((__const unsigned char *) (__const char *) 
(repository))[0] - ((__const unsigned char *) (__const char 
*)(current_parsed_root->directory))[0]); if (__s1_len > 0 && __result == 
0) { __result = (((__const unsigned char *) (__const char *) 
(repository))[1] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[1]); if (__s1_len > 1 && __result == 
0) { __result = (((__const unsigned char *) (__const char *) 
(repository))[2] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[2]); if (__s1_len > 2 && __result == 
0) __result = (((__const unsigned char *) (__const char *) 
(repository))[3] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[3]); } } __result; })) : 
(__extension__ ({ __const unsigned char *__s2 = (__const unsigned char 
*) (__const char *) (current_parsed_root->directory); register int 
__result = (((__const unsigned char *) (__const char *) (repository))[0] 
- __s2[0]); if (__s1_len > 0 && __result == 0) { __result = (((__const 
unsigned char *) (__const char *) (repository))[1] - __s2[1]); if 
(__s1_len > 1 && __result == 0) { __result = (((__const unsigned char *) 
(__const char *) (repository))[2] - __s2[2]); if (__s1_len > 2 && 
__result == 0) __result = (((__const unsigned char *) (__const char *) 
(repository))[3] - __s2[3]); } } __result; }))) : (__builtin_constant_p 
(current_parsed_root->directory) && ((size_t)(const void 
*)((current_parsed_root->directory) + 1) - (size_t)(const void 
*)(current_parsed_root->directory) == 1) && (__s2_len = strlen 
(current_parsed_root->directory), __s2_len < 4) ? (__builtin_constant_p 
(repository) && ((size_t)(const void *)((repository) + 1) - 
(size_t)(const void *)(repository) == 1) ? (__extension__ ({ register 
int __result = (((__const unsigned char *) (__const char *) 
(repository))[0] - ((__const unsigned char *) (__const char 
*)(current_parsed_root->directory))[0]); if (__s2_len > 0 && __result == 
0) { __result = (((__const unsigned char *) (__const char *) 
(repository))[1] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[1]); if (__s2_len > 1 && __result == 
0) { __result = (((__const unsigned char *) (__const char *) 
(repository))[2] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[2]); if (__s2_len > 2 && __result == 
0) __result = (((__const unsigned char *) (__const char *) 
(repository))[3] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[3]); } } __result; })) : 
(__extension__ ({ __const unsigned char *__s1 = (__const unsigned char 
*) (__const char *) (repository); register int __result = __s1[0] - 
((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[0]; if (__s2_len > 0 && __result == 0) 
{ __result = (__s1[1] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[1]); if (__s2_len > 1 && __result == 
0) { __result = (__s1[2] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[2]); if (__s2_len > 2 && __result == 
0) __result = (__s1[3] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[3]); } } __result; }))) : strcmp 
(repository, current_parsed_root->directory)))); }) : strncmp 
(repository, current_parsed_root->directory, strlen 
(current_parsed_root->directory)))) == 0' failed.
cvs [rlog aborted]: received abort signal
cvs: lock.c:178: lock_name: Assertion `(__extension__ 
(__builtin_constant_p (strlen (current_parsed_root->directory)) && 
((__builtin_constant_p (repository) && strlen (repository) < ((size_t) 
(strlen (current_parsed_root->directory)))) || (__builtin_constant_p 
(current_parsed_root->directory) && strlen 
(current_parsed_root->directory) < ((size_t) (strlen 
(current_parsed_root->directory))))) ? __extension__ ({ size_t __s1_len, 
__s2_len; (__builtin_constant_p (repository) && __builtin_constant_p 
(current_parsed_root->directory) && (__s1_len = strlen (repository), 
__s2_len = strlen (current_parsed_root->directory), (!((size_t)(const 
void *)((repository) + 1) - (size_t)(const void *)(repository) == 1) || 
__s1_len >= 4) && (!((size_t)(const void 
*)((current_parsed_root->directory) + 1) - (size_t)(const void 
*)(current_parsed_root->directory) == 1) || __s2_len >= 4)) ? memcmp 
((__const char *) (repository), (__const char *) 
(current_parsed_root->directory), (__s1_len < __s2_len ? __s1_len : 
__s2_len) + 1) : (__builtin_constant_p (repository) && ((size_t)(const 
void *)((repository) + 1) - (size_t)(const void *)(repository) == 1) && 
(__s1_len = strlen (repository), __s1_len < 4) ? (__builtin_constant_p 
(current_parsed_root->directory) && ((size_t)(const void 
*)((current_parsed_root->directory) + 1) - (size_t)(const void 
*)(current_parsed_root->directory) == 1) ? (__extension__ ({ register 
int __result = (((__const unsigned char *) (__const char *) 
(repository))[0] - ((__const unsigned char *) (__const char 
*)(current_parsed_root->directory))[0]); if (__s1_len > 0 && __result == 
0) { __result = (((__const unsigned char *) (__const char *) 
(repository))[1] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[1]); if (__s1_len > 1 && __result == 
0) { __result = (((__const unsigned char *) (__const char *) 
(repository))[2] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[2]); if (__s1_len > 2 && __result == 
0) __result = (((__const unsigned char *) (__const char *) 
(repository))[3] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[3]); } } __result; })) : 
(__extension__ ({ __const unsigned char *__s2 = (__const unsigned char 
*) (__const char *) (current_parsed_root->directory); register int 
__result = (((__const unsigned char *) (__const char *) (repository))[0] 
- __s2[0]); if (__s1_len > 0 && __result == 0) { __result = (((__const 
unsigned char *) (__const char *) (repository))[1] - __s2[1]); if 
(__s1_len > 1 && __result == 0) { __result = (((__const unsigned char *) 
(__const char *) (repository))[2] - __s2[2]); if (__s1_len > 2 && 
__result == 0) __result = (((__const unsigned char *) (__const char *) 
(repository))[3] - __s2[3]); } } __result; }))) : (__builtin_constant_p 
(current_parsed_root->directory) && ((size_t)(const void 
*)((current_parsed_root->directory) + 1) - (size_t)(const void 
*)(current_parsed_root->directory) == 1) && (__s2_len = strlen 
(current_parsed_root->directory), __s2_len < 4) ? (__builtin_constant_p 
(repository) && ((size_t)(const void *)((repository) + 1) - 
(size_t)(const void *)(repository) == 1) ? (__extension__ ({ register 
int __result = (((__const unsigned char *) (__const char *) 
(repository))[0] - ((__const unsigned char *) (__const char 
*)(current_parsed_root->directory))[0]); if (__s2_len > 0 && __result == 
0) { __result = (((__const unsigned char *) (__const char *) 
(repository))[1] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[1]); if (__s2_len > 1 && __result == 
0) { __result = (((__const unsigned char *) (__const char *) 
(repository))[2] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[2]); if (__s2_len > 2 && __result == 
0) __result = (((__const unsigned char *) (__const char *) 
(repository))[3] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[3]); } } __result; })) : 
(__extension__ ({ __const unsigned char *__s1 = (__const unsigned char 
*) (__const char *) (repository); register int __result = __s1[0] - 
((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[0]; if (__s2_len > 0 && __result == 0) 
{ __result = (__s1[1] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[1]); if (__s2_len > 1 && __result == 
0) { __result = (__s1[2] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[2]); if (__s2_len > 2 && __result == 
0) __result = (__s1[3] - ((__const unsigned char *) (__const char *) 
(current_parsed_root->directory))[3]); } } __result; }))) : strcmp 
(repository, current_parsed_root->directory)))); }) : strncmp 
(repository, current_parsed_root->directory, strlen 
(current_parsed_root->directory)))) == 0' failed.



-- 
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2@dave-tech.it
